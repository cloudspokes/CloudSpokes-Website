require 'challenges'
require 'challenge_feeds'

class ChallengesController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :authenticate, :init
  
  def init
    dbdc_client.materialize('Challenge__Feed')
    dbdc_client.materialize('FeedItem')   
    dbdc_client.materialize('User')
    dbdc_client.materialize('FeedComment')

    @dbdc_client = dbdc_client
  end

  
  def index    
    @challenges = Challenges.get_challenges()
    puts '###challenges are' +  @challenges.to_s
  end

  def challenge_feeds(challenge_id)
    # Safe max count is 500, >1000 exceeds salesforce non-admin limitation
    feeds = Challenge__Feed.query("parentId='#{challenge_id}' limit 500")
    puts "### Found #{feeds.size.to_s} Feeds"
    return feeds
  end

  def post_comment
    @challenge_id = params['challenge_id']
    #try to post a comment
    @new_comment = "---Inserting with Ray's ruby app. " + DateTime.now().to_s
    @status = ChallengeFeeds.post_comment(dbdc_client, @challenge_id, @new_comment)
  end

  def show
    @challenge_id = params['id']
    # get challenge detail
    @challenge = Challenges.show_challenge(@challenge_id)


    #Now get the EntitySubscription related to this Challenge and the connection Session.
    #@me = User.find_by_username(dbdc_client.username)
    #connection_user_id =@me['Id']
    #@entity_subscription = ChallengeFeeds.get_entity_subscription(dbdc_client, connection_user_id, "and ParentId='#{@challenge_id}'")

    #get all feeds associated with this challenge.
    @feeds = ChallengeFeeds.challenge_feeds(dbdc_client, @challenge_id)
  end

end
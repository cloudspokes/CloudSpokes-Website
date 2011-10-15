require 'challenges'
require 'challenge_feeds'

class ChallengesController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :authenticate
  
  def index    
    @challenges = Challenges.get_challenges()
    puts '###challenges are' +  @challenges.to_s
  end

  def challenge_feeds(challenge_id)
    chf = dbdc_client.materialize('Challenge__Feed')
    # Safe max count is 500, >1000 exceeds salesforce non-admin limitation
    feeds = Challenge__Feed.query("parentId='#{challenge_id}' limit 500")
    puts "### Found #{feeds.size.to_s} Feeds"
    return feeds
  end

  def show
    @challenge_id = params['id']
    @challenge = Challenges.show_challenge(@challenge_id)

    @me = User.find_by_username(dbdc_client.username)
    connection_user_id =@me['Id']
    #Now get the EntitySubscription related to this Challenge and the connection Session.
    @entity_subscription = ChallengeFeeds.get_entity_subscription(dbdc_client, connection_user_id, "and ParentId='#{@challenge_id}'")

    @feeds = ChallengeFeeds.challenge_feeds(dbdc_client, @challenge_id)
  end

end
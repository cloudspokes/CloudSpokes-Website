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

  # shows all challenges
  def index    
    @challenges = Challenges.get_challenges()
    puts '###challenges are' +  @challenges.to_s
  end

  # retrieves all challenge's chatter feeds, see show method
  def challenge_feeds(challenge_id)
    # Safe max count is 500, >1000 exceeds salesforce non-admin limitation
    feeds = Challenge__Feed.query("parentId='#{challenge_id}' limit 500")
    puts "### Found #{feeds.size.to_s} Feeds"
    return feeds
  end

  # creates a new feed
  def do_new_post_feed
    feed_text = params['feed_text']
    challenge_id = params['challenge_id']
    #try to post a feed_text
    status = ChallengeFeeds.post_feed(dbdc_client, challenge_id, feed_text)
    redirect_to :back  
  end

  #shows a challenge with detail info & comment & reply box
  def show
    @challenge_id = params['id']
    # get challenge detail
    @challenge = Challenges.show_challenge(@challenge_id)

    #get all feeds associated with this challenge.
    @feeds = ChallengeFeeds.challenge_feeds(dbdc_client, @challenge_id)
  end

  #show a new reply box
  def new_reply
    @feeditem_id = params['feeditem_id']
    @challenge_id = params['challenge_id']
    render "#{Rails.root}/app/views/shared/_reply.html.erb", :layout => false
    #render :template => "challenges/reply"
    #render :text => 'new reply box'
  end

  #create a new reply to an existing feed
  def do_new_reply
    @feeditem_id = params['feeditem_id']
    @challenge_id = params['challenge_id']
    @reply_text = params['reply_text']
    ChallengeFeeds.post_comment(dbdc_client, @feeditem_id, @reply_text)
    redirect_to :id => @challenge_id, :action => 'show'
  end
  
end
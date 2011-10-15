require 'pp'
class ChattersController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :authenticate

  def index    
    @me = User.find_by_username(dbdc_client.username)
    
    find('dfd','sdf')
    #create
    #OID or just 'me'
    @feed_items = Databasedotcom::Chatter::UserProfileFeed.find(dbdc_client, @me['Id'])
    puts @feed_items
  end

  def find(member_id, challenge_id)
    results = Databasedotcom::Chatter::UserProfileFeed.find(dbdc_client, "me")
    matched = Array.new
    results.each do |result|
      body = result.raw_hash['body']['messageSegments'].to_s
      puts "body text: " + body
      unless ((body =~ /#cloudspokes/) == nil) && ((body =~ /@@member_id:\S+/) == nil) && ((body =~ /@challenge_id:\S+/) == nil)
        matched << result
      end
    end
    pp "matched size: " + matched.size.to_s
    return matched
  end

  def create
    puts 'now try to create a feed.'
    # Posting to my own account
    #result = Databasedotcom::Chatter::UserProfileFeed.post(dbdc_client, @me['Id'], :text => 'some text')
    # Posting to Challenge__Feed
    result = Databasedotcom::Chatter::UserProfileFeed.post(dbdc_client, @me['Id'], :text => '#cloudspokes @@member_id:123412342134 @challenge_id:asdf3134asdfsadf ' + DateTime.now().to_s)
    #result = Databasedotcom::Chatter::ChallengeFeed.post(dbdc_client, 'a0CU00000003mk9MAA', :text => 'Posting to a challenge Feed ' + DateTime.now().to_s)

    #a0CU00000003mk9MAA
    if result.is_a?(Databasedotcom::Chatter::FeedItem)
      return result
    else
      return nil
    end

  end


end

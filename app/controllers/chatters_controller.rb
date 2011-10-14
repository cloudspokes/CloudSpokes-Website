class ChattersController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :authenticate

  def index
    puts ('asdasdfaasfsf')
    puts ('asdfasdfasfasfas')
    @me = User.find_by_username(dbdc_client.username)
    #OID or just 'me'
    @feed_items = Databasedotcom::Chatter::UserProfileFeed.find(dbdc_client, @me['Id'])

  end

  private

end

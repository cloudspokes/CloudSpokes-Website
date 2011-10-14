require 'pp'
class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate
    puts '### authenticating (ApplicationController).###'
    ENV['access_token'] = dbdc_client.oauth_token
    ENV['instance_url'] = dbdc_client.instance_url

    # config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
    # username = config["username"]
    # password = config["password"]
    ## TODO need to set @client as a global variable, otherwise it is a waste of system resources to create
    # connection for each request. It won't scale.
    # @client = Databasedotcom::Client.new(config)
    # @client.version ='22.0'
    # ENV['access_token'] = @client.authenticate(:username => username, :password => password) # authenticate :username => 'mess@cloudspokes.com.dev091', :password => '74H3yd2NZW'

    puts '### client is ' + dbdc_client.to_s
    pp '### access_token is ' + ENV['access_token']
  end
end

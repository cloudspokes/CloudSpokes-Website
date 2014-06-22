require "auth"

class SessionsController < ApplicationController
    def login
      # really should use the before_filter to do the authentication
    end

    # temp method for fetching a new access token and saving to session. This will change pending OAuth bug fix
    # this same code actually run in the application_helper right now.
    def sfdcauth
      client = Databasedotcom::Client.new("config/databasedotcom.yml")
      ENV['access_token'] = client.authenticate :username => ENV['sfdc_username'], :password => ENV['sfdc_password']
      render :inline => "<html><body><b>New access token from salesforce. Saved to session.</b><br>"+ENV['access_token']+"</body></html>"
    end
    
    def create
        # pass on omniauth hash and provider to our auth module
        as = AuthSession.new(request.env['omniauth.auth'], params[:provider])
        render :inline => "<html><body><b>Our hash:</b><br>"+as.get_hash.to_s + "<br><br><b>Omniauth hash:</b><br>" + request.env['omniauth.auth'].to_s+"</body></html>"
    end
    def failure
        render :inline => "Authentication failed"
    end
end

require "auth"

class SessionsController < ApplicationController
    def login
    end
    
    def sfdcauth
      client = Databasedotcom::Client.new("config/databasedotcom.yml")
      access_token = client.authenticate :username => ENV['sfdc_username'], :password => ENV['sfdc_password']
      render :inline => "<html><body><b>New access token from salesforce:</b><br>"+access_token.to_s+"</body></html>"
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

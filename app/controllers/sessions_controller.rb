require "auth"

class SessionsController < ApplicationController
    def login
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

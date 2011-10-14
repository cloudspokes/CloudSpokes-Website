require 'challenges'

class ChallengesController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :authenticate
  
  def index
    @challenges = Challenges.get_challenges()
    puts '###challenges are' +  @challenges.to_s

  end

  def show
    @challenge = Challenges.show_challenge(params['id'])
   # render :text => 'Challenge is ' + @challenge
  end

end
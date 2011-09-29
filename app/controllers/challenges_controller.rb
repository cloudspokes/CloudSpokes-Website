require 'challenges'

class ChallengesController < ApplicationController

  def index
    @challenges = Challenges.get_challenges()
    # puts @challenges
  end

end
require 'challenges'
require 'time'

class ChallengesController < ApplicationController

  def index
    @challenges = Challenges.get_challenges()
    @challenges.each do |record|
        end_time = Time.parse(record["End_Date__c"])
        if end_time.past?
            record["TimeTillEnd"] = "closed"
        else
            secs = Time.parse(record["End_Date__c"]) - Time.now
            if (secs > 86400)
                record["TimeTillEnd"] = "due in " + (secs/86400).floor.to_s + " days(s)"
            else
                record["TimeTillEnd"] = "due in " + (secs/3600).floor.to_s + " hour(s) " + (secs/60).round.to_s + " minute(s)"
            end
        end
    end
    puts @challenges
  end
  
  def detail
    @challenge_detail = Challenges.get_challenge_detail(params[:id])[0]
    @prizes = Challenges.get_prizes(params[:id])
    @categories = Challenges.get_categories(params[:id])
    end_time = Time.parse(@challenge_detail["End_Date__c"])
    if end_time.past?
        @challenge_detail["TimeTillEnd"] = "Completed"
    else
        secs = Time.parse(@challenge_detail["End_Date__c"]) - Time.now
        @challenge_detail["TimeTillEnd"] = "due in "
        @challenge_detail["TimeTillEnd"] += (secs/86400).floor.to_s + " day(s) "
        secs = secs%86400
        @challenge_detail["TimeTillEnd"] += (secs/3600).floor.to_s + " hour(s) " + ((secs%3600)/60).round.to_s + " minute(s)"
    end
    @prizes.sort {|x,y| y["Place__c"] <=> x["Place__c"]}
    puts @prizes
  end
  
  def registrants
    @challenge_detail = Challenges.get_challenge_detail(params[:id])[0]
    @registrants = Challenges.get_registrants(params[:id])
    @prizes = Challenges.get_prizes(params[:id])
    @prizes.sort {|x,y| y["Place__c"] <=> x["Place__c"]}
    end_time = Time.parse(@challenge_detail["End_Date__c"])
    if end_time.past?
        @challenge_detail["TimeTillEnd"] = "Completed"
    else
        secs = Time.parse(@challenge_detail["End_Date__c"]) - Time.now
        @challenge_detail["TimeTillEnd"] = "due in "
        @challenge_detail["TimeTillEnd"] += (secs/86400).floor.to_s + " day(s) "
        secs = secs%86400
        @challenge_detail["TimeTillEnd"] += (secs/3600).floor.to_s + " hour(s) " + ((secs%3600)/60).round.to_s + " minute(s)"
    end
    puts @registrants
  end
  
  def leaderboard
    tn = Time.now
    this_month = Time.new(tn.year, tn.month)
    this_year = Time.new(tn.year)
    all_time = Time.new(2000)
    @this_month_leaders = ActiveSupport::JSON.decode(Challenges.get_leaderboard(this_month.iso8601(0),1)["data"])
    @this_month_leaders.each do |record|
        record["numwins"] = 0
        record["participations"].each do |participation|
            if participation["place"] == "1"
                record["numwins"] += 1
            end
        end
    end
    @this_year_leaders = ActiveSupport::JSON.decode(Challenges.get_leaderboard(this_year.iso8601(0),1)["data"])
    @this_year_leaders.each do |record|
        record["numwins"] = 0
        record["participations"].each do |participation|
            if participation["place"] == "1"
                record["numwins"] += 1
            end
        end
    end
    @all_time_leaders = ActiveSupport::JSON.decode(Challenges.get_leaderboard(all_time.iso8601(0),1)["data"])
    @all_time_leaders.each do |record|
        record["numwins"] = 0
        record["participations"].each do |participation|
            if participation["place"] == "1"
                record["numwins"] += 1
            end
        end
    end
    puts @this_month_leaders
    puts @this_year_leaders
    puts @all_time_leaders
  end
end

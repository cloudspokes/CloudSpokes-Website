class Challenges 
  
  include HTTParty 
  format :json
  
  headers 'Content-Type' => 'application/json' 
  #headers 'Authorization' => "OAuth #{ENV['access_token']}"
  headers 'Authorization' => "OAuth 00DU0000000IrOZ!ARoAQLwmlcxyktwiCf35IGKW64sFtYheCaqRCEvLc100sJw0wwXDNPaXKWct4h28qp_t6osTMAjg4Hyaz2Cz8dXd7DD6J.8P"

  #get all Challenges
  def self.get_challenges()
    puts '### using auth token: ' + ENV['access_token']
    url = ENV['instance_url'] + '/services/apexrest/v.9/challenges'
    get(url)
  end 

  #show a single Challenge
  def self.show_challenge(challenge_id)
    #apex web service
    #get("https://na12.salesforce.com/services/apexrest/v.9/challenges/#{challenge_id}")
    #This shows more details than the Apex webservice
    url = ENV['instance_url'] + "/services/data/v22.0/sobjects/Challenge__c/#{challenge_id}"
    get(url)
  end

  #show all Categories associated with a single Challenge
  def self.show_challenge_categories_summary(challenge_id)
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/categories")
  end

=begin
  #show a single Category associated with a single Challenge
  def self.show_challenge_category_detail(challenge_id, category_id)
    get("ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/categories/#{category_id}")
  end
=end

  #show a single Category associated with a single Challenge, This is better and shows more details.
  def self.show_challenge_category_detail(category_id)
    get(ENV['instance_url'] + "/services/data/v22.0/sobjects/Challenge_Category__c/#{category_id}")
  end


  #show all Prizes associated with a single Challenge
  def self.show_challenge_prizes_summary(challenge_id)
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes")
  end

  #show a single Prize associated with a single Challenge
  def self.show_challenge_prize_detail(challenge_id, prize_id)
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes/#{prize_id}")
  end

  #show all Reviewers associated with a single Challenge
  def self.show_challenge_reviewers_summary(challenge_id)
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes")
  end

  #show a single Reviewer associated with a single Challenge
  def self.show_challenge_reviewer_detail(challenge_id, reviewer_id)
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes/#{reviewer_id}")
  end
end
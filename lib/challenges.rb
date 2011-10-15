class Challenges 
  
  include HTTParty 
  format :json
  
  #headers 'Content-Type' => 'application/json'
  #headers 'Authorization' => "OAuth #{ENV['access_token']}"
  #headers 'Authorization' => "OAuth 00DU0000000IrOZ!ARoAQI7NAhR69k2y1T14aNdYWlf4.MLRoDQ4gt0OTEFB8.0bU8ilH7fv3TTuOGX9C86BwIwvfRNyHAi72XGslMfE0gJOVFVU"

  def self.set_headers
    headers 'Content-Type' => 'application/json'
    headers 'Authorization' => "OAuth #{ENV['access_token']}"
    puts '### using auth token: ' + ENV['access_token']
  end
  #get all Challenges
  def self.get_challenges()
    set_headers()
    url = ENV['instance_url'] + '/services/apexrest/v.9/challenges'
    result = get(url)
    return result
  end 

  #show a single Challenge
  def self.show_challenge(challenge_id)
    set_headers()
    #apex web service
    #get("https://na12.salesforce.com/services/apexrest/v.9/challenges/#{challenge_id}")
    #This shows more details than the Apex webservice
    url = ENV['instance_url'] + "/services/data/v#{ENV['api_version']}/sobjects/Challenge__c/#{challenge_id}"
    get(url)
  end

  #show all Categories associated with a single Challenge
  def self.show_challenge_categories_summary(challenge_id)
    set_headers()
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/categories")
  end


  # TODO, one of following is better
  #show a single Category associated with a single Challenge
  def self.show_challenge_category_detail(category_id, challenge_id)
    set_headers()
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/categories/#{category_id}")
  end
  
  #show a single Category associated with a single Challenge, This is better and shows more details.
  def self.show_challenge_category_detail(category_id)
    set_headers()
    get(ENV['instance_url'] + "/services/data/v#{ENV['api_version']}/sobjects/Challenge_Category__c/#{category_id}")
  end


  #show all Prizes associated with a single Challenge
  def self.show_challenge_prizes_summary(challenge_id)
    set_headers()
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes")
  end

  #show a single Prize associated with a single Challenge
  def self.show_challenge_prize_detail(challenge_id, prize_id)
    set_headers()
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes/#{prize_id}")
  end

  #show all Reviewers associated with a single Challenge
  def self.show_challenge_reviewers_summary(challenge_id)
    set_headers()
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes")
  end

  #show a single Reviewer associated with a single Challenge
  def self.show_challenge_reviewer_detail(challenge_id, reviewer_id)
    set_headers()
    get(ENV['instance_url'] + "/services/apexrest/v.9/challenges/#{challenge_id}/prizes/#{reviewer_id}")
  end
end
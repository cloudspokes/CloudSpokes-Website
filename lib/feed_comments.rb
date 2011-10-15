
#/data/v23.0/chatter/feed-items/0D5U0000002h0roKAA

class FeedCommentsHelp

  # get EntitySubscription associated between a Connection User and a Challenge (query_filter)
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
end
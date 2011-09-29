class Challenges 
  
  include HTTParty 
  format :json
  
  headers 'Content-Type' => 'application/json' 
  headers 'Authorization' => "OAuth #{ENV['access_token']}"

  def self.get_challenges()   
    get('https://na12.salesforce.com/services/apexrest/v.9/challenges')
  end 
  
end
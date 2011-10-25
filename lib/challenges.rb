class Challenges 
  
  include HTTParty 
  format :json
  
  headers 'Content-Type' => 'application/json' 
  headers 'Authorization' => "OAuth #{ENV['access_token']}"

  def self.get_challenges()   
    get('https://na12.salesforce.com/services/apexrest/v.9/challenges?fields=Id,Name,Description__c,Top_Prize__c,Registered_Members__c,End_Date__c')
  end
  
  def self.get_challenge_detail(id)
    get('https://na12.salesforce.com/services/apexrest/v.9/challenges/'+id+'?fields=Id,Name,Description__c,Additional_Info__c,Comments__c,End_date__c,License__c,Requirements__c,Status__c,Submission_Details__c,Top_Prize__c,Winner_Announced__c,Registered_Members__c')
  end
  
  def self.get_categories(id)
    catnames = []
    cats = get('https://na12.salesforce.com/services/apexrest/v.9/challenges/'+id+'/categories')
    cats.each do |cat|
        catobj = get('https://na12.salesforce.com'+cat['attributes']['url']+'?fields=Category__r.Name')
        catnames.push(catobj['Category__r']['Name'])
    end
    return catnames
  end
  
  def self.get_prizes(id)
    get('https://na12.salesforce.com/services/apexrest/v.9/challenges/'+id+'/prizes?fields=Prize__c,Place__c')
  end
  
  def self.get_registrants(id)
    get('https://na12.salesforce.com/services/apexrest/v.9/participants?challengeid='+id+'&fields=Member__r.Profile_Pic__c,Member__r.Name,Member__r.Total_Wins__c')
  end
  
  def self.get_leaderboard(from_date, page_num)
    get('https://na12.salesforce.com/services/apexrest/v.9/leaderboard?pageNum='+page_num.to_s+'&dateFormat='+from_date.to_s)
  end
end

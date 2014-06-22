class Members

  include HTTParty
  format :json

  def self.set_headers
    headers 'Content-Type' => 'application/json'
    headers 'Authorization' => "OAuth #{ENV['access_token']}"
    puts '### using auth token: ' + ENV['access_token']
  end

  #get all Members
  def self.get_members()
    set_headers()
    url = ENV['instance_url'] + '/services/apexrest/v.9/members'
    result = get(url)
    return result
  end

  #show a single Member
  def self.show_member(member_name)
    set_headers()
    #apex web service
    #get("https://na12.salesforce.com/services/apexrest/v.9/challenges/#{challenge_id}")
    #This shows more details than the Apex webservice
    url = ENV['instance_url'] + "/services/apexrest/v.9/members?search=#{member_name}"
    result = get(url)
    member_url = ENV['instance_url'] + result[0]['attributes']['url']
    # now get the real member
    member_detail = get(member_url)
    return member_detail
  end

  def self.show_member_detail_by_id(member_id)
    set_headers()
    url = ENV['instance_url'] + "/services/data/v22.0/sobjects/Member__c/#{member_id}"
    result = get(url)
    return result
  end

end
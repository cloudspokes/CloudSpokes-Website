class ChallengeFeeds

  # get EntitySubscription associated between a Connection User and a Challenge (query_filter)
  def self.get_entity_subscription (client, user_id, query_filter)
    client.materialize('EntitySubscription')

    # Safe max count is 500, >1000 exceeds salesforce non-admin limitation
    subscribed = EntitySubscription.query("subscriberid ='#{user_id}' #{query_filter} limit 1")
    return subscribed
  end


  def self.challenge_feeds(client, challenge_id)
    chf = client.materialize('Challenge__Feed')
    # Safe max count is 500, >1000 exceeds salesforce non-admin limitation
    feeds = Challenge__Feed.query("parentId='#{challenge_id}' limit 500")
    #puts "### Found #{feeds.size.to_s} Feeds"
    return feeds
  end

end
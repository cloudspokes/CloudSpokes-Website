Rails.application.config.middleware.use OmniAuth::Builder do
  require 'openid/store/filesystem'
  # Change these keys and secrets during final deployment
  provider :twitter, 'ApNeHjGLXl6OWodM5XrnyA', 'kZLOfGZSHXyMYUZsAcB2Kd7HjtQ9rA2vY8o702QNnEs'
  # CloudSpokes
  provider :facebook, '226080650780052', '74f50226d36d4786ccca912320a7cdba'
  provider :linked_in, 'x9onv3r7p08t', 'ma48Y34XpoqHl0XN'
  # CloudSpokes
  provider :github, '0662f9813c10d863eb30', 'e00e82e5b6f7f6189cc394d5b5e2d0dff35ff155'
  provider :openid, OpenID::Store::Filesystem.new('./tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :salesforce, '3MVG9Y6d_Btp4xp74GKa5u49wmNXCfDsNRvhEXULuPdXNm9P9Dut8XBGA.QAuufM_X06Hw5D4JXiYGqEq08mA', '3202477603238349290'
end

# Change to wherever the app is hosted, required only for Salesforce, since it doesnot accept a http:// callback.
OmniAuth.config.full_host = 'http://localhost:3000' 

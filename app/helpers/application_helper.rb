module ApplicationHelper
  
  config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
  client = Databasedotcom::Client.new(config)
  ENV['access_token'] = client.authenticate :username => 'mess@cloudspokes.com.dev091', :password => '74H3yd2NZW'
  
  def s3_image(path, options = {})
    image_tag("http://cloudspokes.s3.amazonaws.com/#{path}", options)
  end
  
end

# A module for sending test Twilio SendGrid Inbound Parse messages
# Usage: ruby ./send.rb [path to file containing test data]
require 'ruby_http_client'
require 'yaml'
require 'optparse'

OPTS = {}
opt = OptionParser.new
opt.on('--host=HOST') {|v| OPTS[:host] = v}
argv = opt.parse!(ARGV)
config = YAML.load_file(File.dirname(__FILE__) + '/config.yml')
host = OPTS[:host] || config['host']
client = SendGrid::Client.new(host: host)
File.open(argv[0]) do |file|
  data = file.read
  headers = {
    'User-Agent' => 'Twilio-SendGrid-Test',
    'Content-Type' => 'multipart/form-data; boundary=xYzZY'
  }
  response = client.post(
    request_body: data, request_headers: headers
  )
  puts response.status_code
  puts response.body
  puts response.headers
end

begin
  require 'sinatra'
rescue LoadError
  puts <<-NOTE
    As of sengrid verison 6, sinatra is no longer specified as a dependency of
    the sendgrid gem. All the functionality of the inbound server is still the same
    and fully supported, but you just need to include the sinatra dependency in your gemfile
    yourself, like so:

        gem 'sinatra', '>= 1.4.7', '< 3'
  NOTE
  raise
end
require 'logger'
require 'json'
require 'yaml'

class Main < Sinatra::Base
  configure :production, :development do
    enable :logging
    set :config, YAML.load_file(File.dirname(__FILE__) + '/config.yml')
  end

  get '/' do
    redirect to('index.html')
  end

  post settings.config['endpoint'] do
    filtered = params.select {|k, v| settings.config['keys'].include?(k)}
    logger.info JSON.pretty_generate(filtered)
  end
end

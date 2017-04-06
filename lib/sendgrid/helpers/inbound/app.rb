require 'sinatra'
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

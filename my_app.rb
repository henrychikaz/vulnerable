require 'sinatra'
require 'erubis'
require 'http'
require 'uri'
require 'sinatra/assetpack'
require 'sinatra/flash'
require 'pp'


set :root, File.dirname(__FILE__) # You must set app root

class MyApp < Sinatra::Base

  register Sinatra::Flash
  register Sinatra::AssetPack
  enable :sessions
  use Rack::Session::Pool

  set :session_secret, '*&(^B234'

  assets {
    serve '/js',     from: './js'        # Default
    serve '/css',     from: './css'        # Default
  }


  get '/' do
    session[:state] ||= []
    #headers "Content-Security-Policy" => "default-src 'self' http://www.w3schools.com;"
    erb :index
  end

  post "/add_feedback" do
    session[:state] << {:name => params["name"], :feedback => params["feedback"], :created_at => Time.now}
    flash.next[:message] = "Thanks for the feedback"
    redirect to("/")
  end

  session_pool = Rack::Session::Pool.new(
      Sinatra::Application
  )
  run! session_pool if __FILE__ == $0

end

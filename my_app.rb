require 'sinatra'
require 'erubis'
require 'http'
require 'sinatra/cookies'
require 'uri'
require 'sinatra/assetpack'
require 'sinatra/flash'
require 'pp'

enable :sessions
set :session_secret, '*&(^B234'

set :root, File.dirname(__FILE__) # You must set app root

register Sinatra::AssetPack

assets {
    serve '/js',     from: './js'        # Default
    serve '/css',     from: './css'        # Default
}

set :bind, '0.0.0.0'
set :port, 3000

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

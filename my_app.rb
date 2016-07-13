require 'sinatra/base'
require 'erubis'
require 'http'
require 'uri'
require 'sinatra/assetpack'
require 'sinatra/flash'
require 'pp'
require File.join("#{File.dirname(__FILE__)}", "modules", "protection_base")
require './helpers/my_view_helper'

#set :root, File.dirname(__FILE__) # You must set app root

class MyApp < Sinatra::Base
  include ::ProtectionBase
  include Helpers::MyViewHelper
  register Sinatra::Flash
  register Sinatra::AssetPack
  enable :sessions
  use Rack::Session::Pool

  # configure do
  #   disable :protection
  # end
  set :session_secret, '*&(^B234'
  set :bind, '0.0.0.0'

  before do
    cache_control :public, :must_revalidate, :no_cache, :no_store
  end

  assets {
    serve '/js',     from: './js'        # Default
    serve '/css',     from: './css'        # Default
  }

  get '/' do
    session[:state] ||= []
    session[:xss_settings] ||= "no_protection"
    implement_protection_strategy_in_response self
    erb :index
  end

  post "/add_feedback" do
    implement_protection_strategy_in_request self
    session[:state] << {:name => params["name"], :feedback => params["feedback"], :created_at => Time.now}
    flash.now[:message] = "Thanks for the feedback!"
    redirect to("/#Guestbook")
  end

  get "/search" do
    flash.now[:search] = params["search"]
    flash.now[:tab] = "Search"
    implement_protection_strategy_in_response self
    erb :index
  end

  post "/update_settings" do
    if params["type"] == "xss"
      session[:xss_settings] = params["value"]
    end

    flash.next[:message] = "Settings updated successfully!"
    redirect to("/#Settings")
  end

  session_pool = Rack::Session::Pool.new(
      Sinatra::Application
  )
  run! if __FILE__ == $0

end

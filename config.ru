require './my_app'
session_pool = Rack::Session::Pool.new(
MyApp
)
run session_pool
require "sinatra/base"
# $LOAD_PATH.unshift("../../sinatra-swagger/lib")
require "sinatra/swagger"
require "zlib"
require "json"
require "time"

require_relative "env"
require_relative "webapp_config"
require_relative "webapp_post_routes"
require_relative "webapp_trip_routes"

puts "Using swagger-sinatra v#{Sinatra::Swagger::VERSION}"
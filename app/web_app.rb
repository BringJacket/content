require "sinatra/base"
$LOAD_PATH.unshift("../../sinatra-swagger/lib")
require "sinatra/swagger"
require "zlib"
require "json"
require "time"

require_relative "env"

puts "Using swagger-sinatra v#{Sinatra::Swagger::VERSION}"

module Travel
  class WebApp < Sinatra::Base
    include GeoUtils
    register Sinatra::Swagger::SpecEnforcer unless production?
    register Sinatra::Swagger::ParamValidator
    swagger "swagger.yaml"

    helpers do
      def list_from_params_for(ar_relation)
        filter = {}
        filter[:user_id] = params['user_id'] if params['user_id']
        page = params['page'] || 1

        items = ar_relation.where(filter).limit(params['limit'] + 1).offset((page - 1) * params['limit'])

        links = {}
        links[:previous] = "#{page - 1}" unless page == 1
        links[:next] = "#{page + 1}" if items.count > params['limit']

        {
          items: items[0...params['limit']],
          links: links
        }
      end
    end

    get "/posts", provides: :json do
      list_from_params_for(Post).to_json
    end

    post "/posts", provides: :json do
      halt(404) unless params[:body]['trip_id'].nil? || Trip.exists?(params[:body]['trip_id'])
      sort_geometry!(params[:body]['geometry'])
      post = Post.create(
        user_id: 1,
        trip_id: params[:body]['trip_id'],
        title: params[:body]['title'],
        geometry: params[:body]['geometry']
      )
      halt(201, post.to_json)
    end

    get "/trips", provides: :json do
      list_from_params_for(Trip).to_json
    end

    post "/trips", provides: :json do
      sort_geometry!(params[:body]['geometry'])
      trip = Trip.create(
        user_id: 1,
        title: params[:body]['title'],
        geometry: params[:body]['geometry']
      )
      halt(201, trip.to_json)
    end
  end
end
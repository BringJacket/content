module Travel
  class WebApp < Sinatra::Base

    ## Trips

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

    get "/trips/*", provides: :json do
      begin
        halt(200, Trip.find(params['trip_id']).to_json)
      rescue ActiveRecord::RecordNotFound
        halt(404)
      end
    end
  end
end
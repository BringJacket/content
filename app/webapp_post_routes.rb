module Travel
  class WebApp < Sinatra::Base

    ## Posts

    get "/posts", provides: :list do
      list_from_params_for(Post).to_json
    end

    post "/posts", provides: :post do
      halt(404) unless params[:body]['trip_id'].nil? || Trip.exists?(params[:body]['trip_id'])
      sort_geometry!(params[:body]['geometry'])
      # TODO: ensure Photo URI is acceptable

      post = Post.create(
        user_id: 1,
        trip_id: params[:body]['trip_id'],
        title: params[:body]['title'],
        geometry: params[:body]['geometry'],
        body: params[:body]['body'],
        photo: params[:body]['photo']
      )
      halt(201, post.to_json)
    end

    get "/posts/*", provides: :post do
      begin
        halt(200, Post.find(params['post_id']).to_json)
      rescue ActiveRecord::RecordNotFound
        halt(404)
      end
    end
  end
end
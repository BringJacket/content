module Travel
  class WebApp < Sinatra::Base
    include GeoUtils
    register Sinatra::Swagger::RecommendedSetup
    swagger "swagger.yaml"

    configure do
      mime_type :post, 'application/vnd.byjp.travel.post.v1+json'
      mime_type :trip, 'application/vnd.byjp.travel.trip.v1+json'
      mime_type :list, 'application/vnd.byjp.travel.list.v1+json'
    end

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

    after do
      headers['Access-Control-Allow-Origin'] = '*'
    end
  end
end
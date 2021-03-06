require "elasticsearch/model"

module Travel
  class Post < ActiveRecord::Base
    include Elasticsearch::Model
    has_one   :trip
    serialize :geometry
    validates :title, presence: true
    validates :geometry, presence: true
    validate  :has_some_content

    def as_json(options = {})
      super(options).reject { |k, v| v.nil? }
    end

    private

    def has_some_content
      if [self.photo, self.body].reject(&:blank?).empty?
        errors[:base] << "A post must include a body, a photo or both."
      end
    end  
  end

  class Trip < ActiveRecord::Base
    include Elasticsearch::Model
    include GeoUtils
    has_many :posts
    serialize :geometry

    def geometry
      coordinates = []
      unless new_record?
        posts.select(:geometry).each do |post|
          coordinates.push(*[*post[:geometry]["coordinates"]])
        end
      end

      trip_geom = read_attribute(:geometry)
      coordinates.push(*[*trip_geom["coordinates"]]) if trip_geom
      
      sort_geometry!(
        "type" => "LineString",
        "coordinates" => coordinates
      )
    end

    def as_json(options = {})
      super(options).reject { |k, v| v.nil? }
    end
  end
end
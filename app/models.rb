require "json"

module Travel
  class Post < ActiveRecord::Base
    has_one :trip
    serialize :geometry

    def as_json(options = {})
      super(options).reject { |k, v| v.nil? }
    end
  end

  class Trip < ActiveRecord::Base
    has_many :posts
    serialize :trip
  end
end
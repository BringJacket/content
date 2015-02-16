module Travel
  class Post < ActiveRecord::Base
    has_one :trip

    def as_json(options = {})
      super(options).reject { |k, v| v.nil? }
    end
  end

  class Trip < ActiveRecord::Base
    has_many :posts
  end
end
require 'active_record'

begin
  require 'dotenv'
  Dotenv.load
rescue LoadError; end

require_relative "geo_json"
require_relative "models"

module Travel
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    adapter:  db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    host:     db.host,
    username: db.user,
    password: db.password,
    database: db.path[1..-1],
    encoding: 'utf8',
    pool:     20
  )
end
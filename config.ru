require "byebug" if ENV["RACK_ENV"] == "development"
require "pry" if ENV["RACK_ENV"] == "development"

HTTP = 'api/http/server'
CBOR = 'api/cbor/server'

# Middleware if needed 
use Rack::CommonLogger

require_relative HTTP 

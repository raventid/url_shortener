require 'sinatra'
require 'sinatra/async'
require 'eventmachine'
require 'em-hiredis'
require 'json'
require 'forwardable'

require "dry-container"
require "dry-auto_inject"


# Set up the container
class Container
  extend Dry::Container::Mixin
end

Container.register("algorithm") do
  # Possible bidirectional algorithms
  require_relative '../../lib/algorithms/revertable/bijective'
  # Possible one-direction algorithms
  require_relative '../../lib/algorithms/hashing/random_string'
  Shortener::Algorithm::RandomString.new 
end

# Storage adapters
Container.register("adapter") do
  require_relative '../../persistence/adapters/no_storage'
  require_relative '../../persistence/adapters/hiredis'
  Shortener::Persistence::MHiredis.new
end

# Storages 
Container.register("storage") do
  require_relative '../../persistence/storage'
  Shortener::Persistence::Storage.new
end

# Validation
Container.register("validate") do
  require_relative '../../operations/url/validations/validate'
  Shortener::Operation::Validate.new 
end

# Operations
Container.register("encode_or_save") do
  require_relative '../../operations/url/encode_or_save'
  Shortener::Operation::EncodeOrSave.new
end

Container.register("decode_or_load") do
  require_relative '../../operations/url/decode_or_load'
  Shortener::Operation::DecodeOrLoad.new
end


Container.register("create") do
  require_relative '../../operations/url/create'
  Shortener::Operation::Create.new
end


Container.register("read") do
  require_relative '../../operations/url/read'
  Shortener::Operation::Read.new
end

# Set up an AutoInject to use our container
Import = Dry::AutoInject(Container)
 

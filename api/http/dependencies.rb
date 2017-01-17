require 'sinatra'
require 'sinatra/async'
require 'eventmachine'
require 'em-hiredis'
require 'json'
require 'forwardable'

require "dry-container"
require "dry-auto_inject"


# Set up the container
class MyContainer
  extend Dry::Container::Mixin
end


# Possible bidirectional algorithms
require_relative '../../lib/algorithms/revertable/bijective'
# Possible one-direction algorithms
require_relative '../../lib/algorithms/hashing/random_string'
MyContainer.register "algorithm", -> { Shortener::Algorithm::RandomString.new }
Import = Dry::AutoInject(MyContainer)


# Storage adapters
require_relative '../../persistence/adapters/no_storage'
require_relative '../../persistence/adapters/hiredis'
MyContainer.register "adapter", -> { Shortener::Persistence::MHiredis.new }
Import = Dry::AutoInject(MyContainer)


# Storages 
require_relative '../../persistence/storage'
MyContainer.register "storage", -> { Shortener::Persistence::Storage.new }
Import = Dry::AutoInject(MyContainer)


# Validation
require_relative '../../operations/url/validations/validate'
MyContainer.register "validate", -> { Shortener::Operation::Validate.new }
Import = Dry::AutoInject(MyContainer)


# Operations
require_relative '../../operations/url/encode_or_save'
require_relative '../../operations/url/decode_or_load'
MyContainer.register "encode_or_save", -> { Shortener::Operation::EncodeOrSave.new }
MyContainer.register "decode_or_load", -> { Shortener::Operation::DecodeOrLoad.new }
Import = Dry::AutoInject(MyContainer)

require_relative '../../operations/url/create'
require_relative '../../operations/url/read'
MyContainer.register "create", -> { Shortener::Operation::Create.new }
MyContainer.register "read", -> { Shortener::Operation::Read.new }
Import = Dry::AutoInject(MyContainer)


# Set up an AutoInject to use our container
Import = Dry::AutoInject(MyContainer)


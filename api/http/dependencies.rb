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


# Possible bidirectional algorithms
require_relative '../../lib/algorithms/revertable/bijective'
# Possible one-direction algorithms
require_relative '../../lib/algorithms/hashing/random_string'
Container.register "algorithm", -> { Shortener::Algorithm::RandomString.new }
Import = Dry::AutoInject(Container)


# Storage adapters
require_relative '../../persistence/adapters/no_storage'
require_relative '../../persistence/adapters/hiredis'
Container.register "adapter", -> { Shortener::Persistence::MHiredis.new }
Import = Dry::AutoInject(Container)


# Storages 
require_relative '../../persistence/storage'
Container.register "storage", -> { Shortener::Persistence::Storage.new }
Import = Dry::AutoInject(Container)


# Validation
require_relative '../../operations/url/validations/validate'
Container.register "validate", -> { Shortener::Operation::Validate.new }
Import = Dry::AutoInject(Container)


# Operations
require_relative '../../operations/url/encode_or_save'
require_relative '../../operations/url/decode_or_load'
Container.register "encode_or_save", -> { Shortener::Operation::EncodeOrSave.new }
Container.register "decode_or_load", -> { Shortener::Operation::DecodeOrLoad.new }
Import = Dry::AutoInject(Container)

require_relative '../../operations/url/create'
require_relative '../../operations/url/read'
Container.register "create", -> { Shortener::Operation::Create.new }
Container.register "read", -> { Shortener::Operation::Read.new }
Import = Dry::AutoInject(Container)


# Set up an AutoInject to use our container
Import = Dry::AutoInject(Container)


require 'sinatra'
require 'sinatra/async'
require 'eventmachine'
require 'em-hiredis'
require 'json'

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
MyContainer.register "algorithm", -> { RandomString.new }


# Storage adapters
require_relative '../../persistence/adapters/no_storage'
require_relative '../../persistence/adapters/hiredis'
MyContainer.register "adapter", -> { Hiredis.new }

# Storages 
require_relative '../../persistence/storage'
MyContainer.register "storage", -> { Storage.new }

# Validation
require_relative '../../operations/url/validations/validate'
MyContainer.register "validate", -> { Validate.new }

require_relative '../../operations/url/encode_or_save'
require_relative '../../operations/url/decode_or_load'
MyContainer.register "encode_or_save", -> { EncodeOrSave.new }
MyContainer.register "decode_or_load", -> { DecodeOrLoad.new }

# Set of possible operations
require_relative '../../operations/url/create'
require_relative '../../operations/url/redirect'
MyContainer.register "create", -> { Create.new }
MyContainer.register "redirect", -> { Redirect.new }


# Set up an AutoInject to use our container
AutoInject = Dry::AutoInject(MyContainer)


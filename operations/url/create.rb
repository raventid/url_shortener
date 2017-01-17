require "dry-container"
require "dry-auto_inject"
require_relative 'validations/validate'
require_relative 'encode_or_save'
require_relative '../../persistence/storage'
require_relative '../../lib/algorithms/hashing/random_string'


# Set up the container
class MyContainer
  extend Dry::Container::Mixin
end
# This time, register our objects without passing any dependencies
#MyContainer.register "validate", -> { Validate.new }
MyContainer.register "encode_or_save", -> { EncodeOrSave.new }
MyContainer.register "create", -> { Create.new }
MyContainer.register "storage", -> { Storage.new }
MyContainer.register "algorithm", -> { RandomString.new }


# Set up an AutoInject to use our container
AutoInject = Dry::AutoInject(MyContainer)

#require 'import'

class Create
  include AutoInject["validate", "encode_or_save"]
  #include Import["validate"]

  def call(url)
    if validate.(url)
      { url: encode_or_save.(url) }
    else
      { error: "Parameter 'longUrl' is empty" } # is it really you?
    end
  end
end

require "dry-container"
require "dry-auto_inject"
require_relative 'decode_or_load'
require_relative '../../persistence/storage'
require_relative '../../lib/algorithms/hashing/random_string'


# Set up the container
class MyContainer
  extend Dry::Container::Mixin
end
# This time, register our objects without passing any dependencies
MyContainer.register "decode_or_load", -> { DecodeOrLoad.new }
MyContainer.register "storage", -> { Storage.new }
MyContainer.register "algorithm", -> { RandomString.new }


# Set up an AutoInject to use our container
AutoInject = Dry::AutoInject(MyContainer)




class Redirect

  include AutoInject["decode_or_load"]

  def call(code)
    load_or_decode_url.(code)
  end
end

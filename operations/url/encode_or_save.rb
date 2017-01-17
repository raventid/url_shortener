require "dry-container"
require "dry-auto_inject"
require_relative '../../persistence/storage'
require_relative '../../lib/algorithms/hashing/random_string'

# Set up the container
class MyContainer
  extend Dry::Container::Mixin
end
# This time, register our objects without passing any dependencies
MyContainer.register "storage", -> { Storage.new }
MyContainer.register "algorithm", -> { RandomString.new }

# Set up an AutoInject to use our container
AutoInject = Dry::AutoInject(MyContainer)


class EncodeOrSave
#require 'pry'; binding.pry
  include AutoInject["storage", "algorithm"]

  def call(url)
    short_url = algorithm.encode(url) 
    storage.set(short_url, url)
    '/' + short_url # hardcode, remove this crap
  end
end

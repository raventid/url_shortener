require 'forwardable'
require_relative 'adapters/hiredis'
require_relative 'adapters/no_storage'

class Storage

  #include AutoInject["adapter"]
  extend Forwardable

  def initialize(opts={})
    @adapter = Persistence::Adapters::Hiredis.new  
  end

  def_delegators :@adapter, :get, :set
end

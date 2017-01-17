module Shortener
	module Persistence
class Storage
  include Import["adapter"]
  extend Forwardable

  def_delegators :adapter, :get, :set
end
	end
end

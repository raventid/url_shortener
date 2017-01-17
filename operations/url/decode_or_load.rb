module Shortener
	module Operation
class DecodeOrLoad
  include Import["storage", "algorithm"]

  def call(code)
	  algorithm.decode(code) || storage.get(code)
  end
end
	end
end

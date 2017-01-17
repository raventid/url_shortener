module Shortener
	module Operation
class EncodeOrSave
  include Import["storage", "algorithm"]

  def call(url)
    short_url = algorithm.encode(url) 
    storage.set(short_url, url)
    short_url 
  end
end
	end
end

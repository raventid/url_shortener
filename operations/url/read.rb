module Shortener
	module Operation
class Read
  include Import["decode_or_load"]

  def call(code)
    load_or_decode_url.(code)
  end
end
	end
end

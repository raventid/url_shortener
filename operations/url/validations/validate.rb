module Shortener
	module Operation
class Validate
	def call(url)
		if url.nil? || url == ''
			{ error: "Parameter 'longUrl' is empty" } 
		else 
			{ error: nil }
		end
	end
end
	end
end

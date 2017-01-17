module Shortener
  module Operation
    class Validate
      def call(url)
        if url.nil? || url == ''
          { error: "Empty request param" } 
        else 
          { error: nil }
        end
      end
    end
  end
end

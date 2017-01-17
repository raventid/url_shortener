module Shortener
  module Operation
    class Read
      include Import["decode_or_load"]

      def call(code)
        decode_or_load.(code)
      end
    end
  end
end

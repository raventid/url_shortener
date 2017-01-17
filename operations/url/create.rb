module Shortener
  module Operation
    class Create
      include Import["validate", "encode_or_save"]

      def call(url)
        validated = validate.(url)

        if validated[:error] 
          { error: validated[:error] }
        else
          { url: encode_or_save.(url) }
        end
      end
    end
  end
end

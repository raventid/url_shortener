module Shortener
  module Persistence
    # If we use encode/decode algorithm, we won't need any real storage
    class NoStorage
      def initialize(config={}); end

      def get(_key); end

      def set(_key, _value); end
    end
  end
end

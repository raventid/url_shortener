module Shortener
  module Algorithm
    class RandomString
      POSSIBILITIES = 99999999
      LENGTH = 36 

      def encode(_val)
        rand(POSSIBILITIES).to_s(LENGTH)
      end

      def decode(_val); end
    end
  end
end

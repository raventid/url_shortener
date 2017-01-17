module Shortener
  module Persistence
    class MHiredis

      extend Forwardable

      def initialize
        @driver = EM::Hiredis.connect
      end

      def_delegators :@driver, :get, :set
    end
  end
end

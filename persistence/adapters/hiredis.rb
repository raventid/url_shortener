require 'forwardable'

module Persistence
  module Adapters
    class Hiredis

      extend Forwardable

      def initialize(opts={})
        @driver = EM::Hiredis.connect
      end

      def_delegators :@driver, :get, :set
    end
  end
end

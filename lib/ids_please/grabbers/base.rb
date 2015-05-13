class IdsPlease
  module Grabbers
    class Base

      attr_reader :avatar, :display_name, :link

      def initialize(link)
        @link = link
      end

      def grab
      end

      def network_id
      end

    end
  end
end

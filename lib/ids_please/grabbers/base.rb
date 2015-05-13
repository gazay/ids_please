require 'open-uri'

class IdsPlease
  module Grabbers
    class Base

      attr_reader :avatar, :display_name, :link, :page_source, :network_id, :data

      def initialize(link)
        @link = link
      end

      def grab
      end

    end
  end
end

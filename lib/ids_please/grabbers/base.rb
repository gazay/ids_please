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

      def to_s
        line = ''
        self.instance_variables.each do |iv|
          next if iv == :@page_source
          val = self.instance_variable_get(iv)
          next if val.nil? || val == ''
          line += ", #{iv}=#{val}"
        end
        "#{self.class}##{self.object_id} #{line[1..-1]}"
      end

      def inspect
        to_s
      end

    end
  end
end

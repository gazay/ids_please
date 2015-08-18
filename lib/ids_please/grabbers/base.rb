require 'open-uri'

class IdsPlease
  module Grabbers
    class Base
      
      def self.interact(links)
        links.map { |l| self.new(l).grab_link }
      end

      attr_reader :avatar,
                  :display_name,
                  :username,
                  :link,
                  :page_source,
                  :network_id,
                  :data,
                  :counts

      def initialize(link)
        @link = link
      end

      def grab_link(_link)
        throw 'Base grabber can not grab anything'
      end

      def to_s
        line = ''
        self.instance_variables.each do |iv|
          next if iv == :@page_source
          val = self.instance_variable_get(iv)
          next if val.nil? || val == ''
          line += ", \n#{iv}=#{val}"
        end
        "#{self.class}##{object_id} #{line[1..-1]}"
      end

      def to_h
        {
          avatar: avatar,
          display_name: display_name,
          username: username,
          link: link,
          page_source: page_source,
          network_id: network_id,
          data: data
        }
      end

      def inspect
        to_s
      end

      def page_source
        @page_source ||= open(link).read
      end

      def errors
        @errors ||= []
      end

      def record_error(event, message)
        errors << "#{event} has #{message}"
      end
      
    end
  end
end

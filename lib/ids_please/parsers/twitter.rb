class IdsPlease
  class Twitter < IdsPlease::BaseParser

    MASK = /twitter/i

    class << self
      private

      def parse_link(link)
        if link.path =~ /%23!/
          id = link.path.sub(/\A\/%23!\//, '')
          id.split(/[\/\?#]/).first
        else
          super
        end
      end
    end

  end
end

class IdsPlease
  class Reddit < IdsPlease::BaseParser

    MASK = /reddit/i

    class << self
      private

      def parse_link(link)
        link.path.split('/')[2]
      end
    end

  end
end

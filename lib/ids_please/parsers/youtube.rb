class IdsPlease
  class Youtube < IdsPlease::BaseParser

    MASK = /youtu\.be|youtube/i

    class << self
      private

      def parse_link(link)
        if link.path =~ /channels|user/
          link.path.split('/')[2]
        else
          link.path.split('/')[1]
        end
      end
    end

  end
end

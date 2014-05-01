class IdsPlease
  class Youtube < IdsPlease::BaseParser

    MASK = /youtu\.be|youtube/i

    private

    def self.parse_link(link)
      if link.path =~ /channels|user/
        link.path.split('/')[2]
      else
        link.path.split('/')[1]
      end
    end

  end
end

class IdsPlease
  class Youtube < IdsPlease::BaseParser

    MASK = /youtu\.be|youtube/i

    def self.parse_link(link)
      if link.path =~ /channels/
        link.path.split('/')[2]
      else
        link.path.split('/')[1]
      end
    end

  end
end

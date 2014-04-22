class IdsPlease::Twitter < IdsPlease::BaseNetwork

  MASK = /twitter/i

  def self.parse_link(link)
    if link.path =~ /%23!/
      id = link.path.sub(/\A\/%23!\//, '')
      id.split(/[\/\?#]/).first
    else
      link.path.split('/')[1]
    end
  end

end

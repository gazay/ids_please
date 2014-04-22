class IdsPlease::GooglePlus < IdsPlease::BaseNetwork

  MASK = /google/i

  def self.parse(links)
    links.map { |l| parse_link(l) }.compact
  end

  def self.parse_link(link)
    if link.host == 'google.com'
      link.path.split('/')[1]
    else
      link.path.match(/\/(\d{2,})\//).try(:[], 1)
    end
  end

end

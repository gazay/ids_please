class IdsPlease::Odnoklassniki < IdsPlease::BaseNetwork

  MASK = /odnoklassniki/i

  def self.parse_link(link)
    if link.path =~ /\/profile\//
      link.path.split('/').last
    elsif link.path.split('/').size == 2
      link.path.split('/').last
    end
  end

end

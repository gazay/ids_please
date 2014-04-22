class IdsPlease::Facebook < IdsPlease::BaseNetwork

  MASK = /fb\.me|fb\.com|facebook/i

  def self.parse_link(link)
    if link.query.present?
      query = CGI.parse(link.query)
      query['id'].first if query.keys.include?('id')
    elsif link.path =~ /\/pages\//
      link.path.split('/').last
    else
      link.path.split('/')[1]
    end
  end

end

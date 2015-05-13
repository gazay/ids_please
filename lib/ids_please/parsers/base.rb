class IdsPlease
  module Parsers
    class Base

      class << self
        def to_sym
          self.name.split('::').last.downcase.to_sym
        end

        def interact(links)
          links.map do |l|
            id = parse_link(l)
            matched_id = id.match(valid_id_regex) if id
            matched_id[1] if matched_id
          end.compact
        end

        private

        def parse_link(link)
          link.path.split('/')[1]
        end

        def valid_id_regex
          /\A([\w\.\+-]{2,})/
        end
      end

    end
  end
end

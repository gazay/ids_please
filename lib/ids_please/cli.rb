class IdsPlease
  module CLI
    def self.run(args)
      command = args.shift
      case command
      when 'grab', 'parse', 'recognize'
      when 'help', nil
        help
        exit
      else
        abort "Unknown command. Enter 'ids_please help' for instructions"
      end

      links = args
      if links.empty?
        abort "You didn't enter any links. Enter 'ids_please help' for instructions"
      end

      ids = IdsPlease.new(*links)
      case command
      when 'grab'
        grab(ids)
      when 'parse'
        parse(ids)
      when 'recognize'
        recognize(ids)
      end
    end

    module_function

    def grab(ids)
      ids.grab
      ids.grabbed.each do |social_network, grabbers_array|
        puts social_network.to_s.capitalize + ': '
        grabbers_array.each do |grabber|
          grabber.to_h.each do |property, value|
            unless value.nil? || value.to_s.empty? || property == :page_source

              if value.class == Hash
                value.delete_if { |_, v| v.nil? }
                unless value.empty?
                  puts "  #{property}: "
                  value.each do |k, v|
                    puts "    #{k}: #{v}"
                  end
                end
              else
                puts "  #{property}: #{value}"
              end

            end
          end
          puts "\n" unless grabbers_array.last == grabber
        end
        puts "\n" unless ids.grabbed.to_a.last[0] == social_network
      end
    end

    def parse(ids)
      ids.parse
      ids.parsed.each do |social_network, permalinks_array|
        puts social_network.to_s.capitalize + ': '
        permalinks_array.each do |permalink|
          puts "  #{permalink}"
        end
        puts "\n" unless ids.parsed.to_a.last[0] == social_network
      end
    end

    def recognize(ids)
      ids.recognize
      unless ids.recognized.empty?
        puts 'Recognized:'
        ids.recognized.each do |social_network, urls_array|
        puts "  #{social_network.to_s.capitalize}: "
        urls_array.each do |url|
          puts "    #{url}"
        end
        puts "\n"
        end
      end

      unless ids.unrecognized.empty?
        puts 'Unrecognized:'
        ids.unrecognized.each do |url|
          puts "  #{url}"
        end
      end
    end

    def help
      puts
        <<-HELP
          IDs, please
          Grab some hidden in html data from social account page
          Get social network IDs or screen names from links to social network accounts

          Usage:
            ids_please command [links]

          Available commands:
            grab          grab some hidden in html data from social account page (avatar, username, id...)
            parse         get screen names from links to social network accounts
            recognize     check that the link is for a known social network

          Examples:
            ids_please grab https://instagram.com/microsoft
            ids_please parse https://facebook.com/Microsoft https://instagram.com/microsoft
        HELP
    end
  end
end

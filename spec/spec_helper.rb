require 'ids_please'
Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

RSpec.configure do |c|
  c.filter_run_excluding external: true
end
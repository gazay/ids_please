require 'ids_please'

RSpec.configure do |c|
  c.filter_run_excluding external: true
end
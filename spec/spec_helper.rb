require 'simplecov'

SimpleCov.start do
  add_group "Models", "cgtrader_levels/models"
end


require 'rubygems'
require 'bundler/setup'

require 'support/init_database'
require 'support/database_cleaner'

require 'cgtrader_levels'

RSpec.configure { |config| }

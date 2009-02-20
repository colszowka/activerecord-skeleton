require 'activesupport'
require 'activerecord'

# Find environment
RACK_ENV = ENV['RACK_ENV'] || 'development' unless defined? RACK_ENV

# Load db config and establish connection
ActiveRecord::Base.establish_connection YAML.load(File.read(File.join(File.dirname(__FILE__), 'config', 'database.yml'))).with_indifferent_access[RACK_ENV]

# Setup logger for activerecord
ActiveRecord::Base.logger = Logger.new(File.open(File.join(File.dirname(__FILE__), 'log', "#{RACK_ENV}.log"), 'a'))

# Load libs from lib/
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each {|lib| require lib }

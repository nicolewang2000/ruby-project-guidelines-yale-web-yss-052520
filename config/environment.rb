require 'bundler'
require 'tabulo'
require 'table_print'
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil

require_all 'lib'

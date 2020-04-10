require 'redis'
require 'database_cleaner/redis'
require 'database_cleaner/spec'

module DatabaseCleaner
  RSpec.describe Redis do
    it_behaves_like "a database_cleaner adapter"
  end
end


require "database_cleaner/redis/version"
require "database_cleaner/core"
require "database_cleaner/redis/truncation"

module DatabaseCleaner
  module Redis
    def self.available_strategies
      [:truncation]
    end
  end
end

DatabaseCleaner[:redis].strategy = :truncation

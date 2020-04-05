require "database_cleaner/redis/version"
require "database_cleaner/core"
require "database_cleaner/redis/truncation"

DatabaseCleaner[:redis].strategy = :truncation

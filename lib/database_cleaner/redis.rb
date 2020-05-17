require "database_cleaner/redis/version"
require "database_cleaner/core"
require "database_cleaner/redis/deletion"

DatabaseCleaner[:redis].strategy = :deletion

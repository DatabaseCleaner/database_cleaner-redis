# Database Cleaner Adapter for Redis

[![Build Status](https://travis-ci.org/DatabaseCleaner/database_cleaner-redis.svg?branch=master)](https://travis-ci.org/DatabaseCleaner/database_cleaner-redis)
[![Code Climate](https://codeclimate.com/github/DatabaseCleaner/database_cleaner-redis/badges/gpa.svg)](https://codeclimate.com/github/DatabaseCleaner/database_cleaner-redis)
[![codecov](https://codecov.io/gh/DatabaseCleaner/database_cleaner-redis/branch/master/graph/badge.svg)](https://codecov.io/gh/DatabaseCleaner/database_cleaner-redis)

Clean your Redis databases with Database Cleaner.

See https://github.com/DatabaseCleaner/database_cleaner for more information.

## Installation

```ruby
# Gemfile
group :test do
  gem 'database_cleaner-redis'
end
```

## Supported Strategies

The redis adapter only has one strategy: the deletion strategy.

## Strategy configuration options

`:only` and `:except` may take a list of strings to be passed to [`keys`](https://redis.io/commands/keys)):

```ruby
# Only delete the "users" key, and keys that start with "cache".
DatabaseCleaner[:redis].strategy = :deletion, { only: ["users", "cache*"] }

# Delete all keys except the "users" key.
DatabaseCleaner[:redis].strategy = :deletion, { except: ["users"] }
```

## Adapter configuration options

`#db` defaults to `Redis.new`, but can be specified manually in a few ways:

```ruby
# Redis URI string:
DatabaseCleaner[:redis].db = "redis://localhost:6379/0"

# Redis connection object:
DatabaseCleaner[:redis].db = Redis.new(url: "redis://localhost:6379/0")

# Back to default:
DatabaseCleaner[:redis].db = :default
```

## COPYRIGHT

See [LICENSE](LICENSE) for details.

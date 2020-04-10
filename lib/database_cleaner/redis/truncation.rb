require "database_cleaner/strategy"

module DatabaseCleaner
  module Redis
    class Truncation < Strategy
      def initialize only: [], except: []
        @only = only
        @except = except
      end

      def clean
        only = expand_keys(@only)
        except = expand_keys(@except)

        if only.none? && except.none?
          connection.flushdb
        else
          tables_to_clean(connection.keys, only: only, except: except).each do |key|
            connection.del key
          end
        end

        connection.quit unless db == :default
      end

      private

      def expand_keys keys
        keys.flat_map { |key| connection.keys(key) }
      end

      def connection
        @connection ||= begin
          if db == :default
            ::Redis.new
          elsif db.is_a?(::Redis) # pass directly the connection
            db
          else
            ::Redis.new(url: db)
          end
        end
      end
    end
  end
end

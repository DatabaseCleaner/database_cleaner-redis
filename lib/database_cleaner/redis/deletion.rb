require "database_cleaner/strategy"

module DatabaseCleaner
  module Redis
    class Deletion < Strategy
      def initialize only: nil, except: nil
        @only = only
        @except = except
      end

      def clean
        if @only.nil? && @except.nil?
          connection.flushdb
        else
          keys_to_delete.each do |key|
            connection.del key
          end
        end

        connection.quit unless db == :default
      end

      private

      def keys_to_delete
        only = @only.nil? ? connection.keys : expand_keys(@only)
        except = @except.nil? ? [] : expand_keys(@except)
        (only - except)
      end

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

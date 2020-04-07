require "database_cleaner/generic/base"
require "database_cleaner/generic/truncation"

module DatabaseCleaner
  module Redis
    def self.available_strategies
      %i[truncation]
    end

    def self.default_strategy
      available_strategies.first
    end

    class Truncation
      include DatabaseCleaner::Generic::Base
      include DatabaseCleaner::Generic::Truncation

      def db
        @db ||= :default
      end
      attr_writer :db

      alias_method :url, :db

      def clean
        if @only
          @only.each do |term|
            connection.keys(term).each { |k| connection.del k }
          end
        elsif @tables_to_exclude
          keys_except = []
          @tables_to_exclude.each { |term| keys_except += connection.keys(term) }
          connection.keys.each { |k| connection.del(k) unless keys_except.include?(k) }
        else
          connection.flushdb
        end
        connection.quit unless url == :default
      end

      private

      def connection
        @connection ||= begin
          if url == :default
            ::Redis.new
          elsif db.is_a?(::Redis) # pass directly the connection
            db
          else
            ::Redis.new(url: url)
          end
        end
      end
    end
  end
end

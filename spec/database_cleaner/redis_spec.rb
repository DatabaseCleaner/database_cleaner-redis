require 'redis'
require 'database_cleaner/redis'
require 'database_cleaner/spec'

module DatabaseCleaner
  RSpec.describe Redis do
    it_behaves_like "a database_cleaner adapter"

    it "has a default_strategy of truncation" do
      expect(described_class.default_strategy).to eq(:truncation)
    end
  end
end


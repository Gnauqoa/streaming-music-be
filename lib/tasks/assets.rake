# frozen_string_literal: true

require 'csv'

namespace :assets do
  task import: :environment do
    results = CSV.parse(File.read(File.join(File.dirname(__FILE__), 'assets.csv')))

    platform = Platform.first

    results[1..].each do |result|
      puts "Create asset with key: #{result[0]}"

      ::Asset.create!(
        platform:,
        key: result[0],
        description: result[1]
      )
    end
  end
end

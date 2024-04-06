# frozen_string_literal: true

require 'csv'

namespace :we_slot_games do
  task import: :environment do
    results = CSV.parse(File.read(File.join(File.dirname(__FILE__), 'we_slot_games.csv')))
    category = We::GameCategory.find_by(code: 'Slot')

    results[1..].each do |result|
      next if We::Game.find_by(external_game_id: result[1])

      puts "Create slot game: #{result[3]}"

      We::Game.create!(
        external_game_type: result[0],
        external_game_id: result[1],
        cn_name: result[2],
        en_name: result[3],
        zh_name: result[4],
        id_name: result[5],
        th_name: result[6],
        vi_name: result[7],
        ko_name: result[8],
        ja_name: result[9],
        pt_name: result[10],
        is_maintained: false,
        we_game_category_id: category.id
      )
    end
  end
end

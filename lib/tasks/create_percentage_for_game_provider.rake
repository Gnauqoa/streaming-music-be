task :create_percentage_for_game_provider => :environment do
  ActiveRecord::Base.transaction do
    begin
      game_provider_id = GameProvider.find_by!(name: 'Kplay').id
      agent_1 = Agent.find_by(first_name: 'Teddy', last_name: 'Summer')
      game_provider_1 = GameProvider.find(game_provider_id)
      game_providers_agent_1_1 = agent_1.game_providers_agents.create!(game_provider: game_provider_1, percentage: 80)
      agent_2 = Agent.find_by(first_name: 'John', last_name: 'Snow')
      game_providers_agent_2_1 = agent_2.game_providers_agents.create!(game_provider: game_provider_1, percentage: 60)
      agent_3 = Agent.find_by(first_name: 'Pike', last_name: 'Snow')
      game_providers_agent_3_1 = agent_3.game_providers_agents.create!(game_provider: game_provider_1, percentage: 40)
      agent_4 = Agent.find_by(first_name: 'Hoang', last_name: 'Snow')
      game_providers_agent_4_1 = agent_4.game_providers_agents.create!(game_provider: game_provider_1, percentage: 20)
    rescue ActiveRecord::RecordNotFound => e
      puts "Error: #{e.message}"
      raise ActiveRecord::Rollback
    end
  end
end
# frozen_string_literal: true

class PlatformPolicy < ApplicationPolicy
  def view_games?
    current_agent.present?
  end

  def manage_user_transactions?
    current_agent.rank == Agent::COMPANY
  end

  def manage_agent?
    current_agent.rank != Agent::AGENT
  end

  def manage_players?
    current_agent.present?
  end

  def manage_bet_results?
    current_agent.present?
  end

  def manage_ip_addresses?
    current_agent.rank == Agent::COMPANY
  end

  def manage_bank_accounts?
    current_agent.rank == Agent::COMPANY
  end

  def manage_deposit_crypto_addres?
    current_agent.rank == Agent::COMPANY
  end

  def manage_games?
    current_agent.rank == Agent::COMPANY
  end

  def manage_platform_settings?
    current_agent.rank == Agent::COMPANY
  end

  def manage_assets?
    current_agent.rank == Agent::COMPANY
  end

  def manage_bonus_program?
    current_agent.rank == Agent::COMPANY
  end
end

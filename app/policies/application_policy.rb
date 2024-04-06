# frozen_string_literal: true

class ApplicationPolicy
  class Scope
    def resolve
      scope = scope.where(platform_id: current_agent.platform_id)
      if current_agent.rank == Agent::COMPANY
        scope
      else
        scope.where(agent_id: current_agent.id)
      end
    end
  end

  attr_reader :current_user, :current_agent, :record

  def initialize(current_user: nil, current_agent: nil, record: nil)
    @current_user = current_user
    @current_agent = current_agent
    @record = record
  end

  protected

  def current_agent?
    current_agent.present?
  end

  def platform
    current_user.platform || current_agent.platform
  end
end

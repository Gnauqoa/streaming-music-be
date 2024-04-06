# frozen_string_literal: true

class AgentDecorator < Draper::Decorator
  delegate_all

  def jwt_payload
    {
      agent: {
        id: id,
        username: username
      },
      exp: (Time.current + 15.days).to_i
    }
  end
end

# frozen_string_literal: true

class Test
  include Sidekiq::Job

  def perform
    Rails.logger.info 'Test worker running'
  end
end

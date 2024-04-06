# frozen_string_literal: true

module Pragmatic
  class PullBetRecordsWorker
    include Sidekiq::Job

    def perform(game_id, user_id, hour, date_played)
      service = GetBetRecord.new(game_id:, user_id:, hour:, date_played:).call

      if service.success?
        Rails.logger.info "Worker Pragmatic::PullBetRecordsWorker success on user_id: #{user_id}"
        return
      end

      Rails.logger.error "Worker Pragmatic::PullBetRecordsWorker failed on user_id: #{user_id}, info: #{service.failure}"
      raise service.errors.full_messages.join(', ')
    end
  end
end

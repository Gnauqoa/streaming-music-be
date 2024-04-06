# frozen_string_literal: true

module Pragmatic
  class UpdateWinLossWorker
    include Sidekiq::Job

    def perform(round_id)
      service = UpdateWinLoss.new(round_id:).call

      if service.success?
        Rails.logger.info "Worker Pragmatic::UpdateWinLoss success on round_id: #{round_id}"
        return
      end

      Rails.logger.error "Worker Pragmatic::UpdateWinLoss failed on round_id: #{round_id}, info: #{service.failure}"
      raise service.errors.full_messages.join(', ')
    end
  end
end

# frozen_string_literal: true

module We
  class UpdateWinLossWorker
    include Sidekiq::Job

    def perform(bet_id)
      service = UpdateWinLoss.new(bet_id:).call

      if service.success?
        Rails.logger.info "Worker We::UpdateWinLoss success on bet_id: #{bet_id}"
        return
      end

      Rails.logger.error "Worker We::UpdateWinLoss failed on bet_id: #{bet_id}, info: #{service.failure}"
      raise service.errors.full_messages.join(', ')
    end
  end
end

# frozen_string_literal: true

class ResolveBetResults
  include Sidekiq::Job

  def perform
    BetResult.processing.where('created_at < ?', 5.minutes.ago).order(:id).each do |bet_result|
      Games::GetResult.call(bet_result:)
    end
  end
end

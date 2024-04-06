# frozen_string_literal: true

module We
  class PullBetRecords
    include Sidekiq::Job

    def perform
      task = TaskScheduler.find_by(task_type: :pull_we_bet_records)

      if task
        start_time = task.last_run_at - 4.minutes
        end_time = Time.current

        result = GetBetRecord.new(start_time:, end_time:).call

        raise StandardError(:error) unless result.success?

        task.update(last_run_at: end_time)
      else
        start_time = Time.current - 1.day
        end_time = Time.current

        result = GetBetRecord.new(start_time:, end_time:).call

        raise StandardError(:error) unless result.success?

        TaskScheduler.create!(task_type: :pull_we_bet_records, last_run_at: end_time)
      end
    end
  end
end

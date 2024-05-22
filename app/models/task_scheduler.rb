# frozen_string_literal: true

class TaskScheduler < ApplicationRecord
  enum task_type: {
    pull_we_bet_records: 0
  }
end

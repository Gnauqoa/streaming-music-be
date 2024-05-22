# frozen_string_literal: true

class BetResult < ApplicationRecord
  validates_uniqueness_of :txn_id
  validates_presence_of :txn_id

  belongs_to :user
  belongs_to :game
  belongs_to :platform

  enum status: {
    processing: 0,
    canceled: 1,
    resolved: 2
  }

  attr_accessor :bet_detail_url
end

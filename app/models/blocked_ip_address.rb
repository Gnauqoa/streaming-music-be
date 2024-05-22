# frozen_string_literal: true

class BlockedIpAddress < ApplicationRecord
  belongs_to :agent

  validates :ip_address, presence: true, uniqueness: true

  def self.blocked?(ip_address)
    BlockedIpAddress.where(ip_address:).exists?
  end

  def self.block!(ip_address, reason, agent)
    BlockedIpAddress.create!(ip_address:, reason:, agent:)
  end
end

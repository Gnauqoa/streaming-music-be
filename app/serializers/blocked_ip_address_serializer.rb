# frozen_string_literal: true

class BlockedIpAddressSerializer < ActiveModel::Serializer
  attributes :id, :ip_address, :reason, :created_at, :updated_at
end

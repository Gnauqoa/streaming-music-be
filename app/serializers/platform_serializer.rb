# frozen_string_literal: true

class PlatformSerializer < ActiveModel::Serializer
  attributes :id, :name, :client_id, :public_key, :created_at, :updated_at
end

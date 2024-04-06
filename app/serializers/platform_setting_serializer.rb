# frozen_string_literal: true

class PlatformSettingSerializer < ActiveModel::Serializer
  attributes :id, :key, :value, :description, :created_at, :updated_at
end

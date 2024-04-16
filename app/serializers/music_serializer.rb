# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :created_at, :updated_at
end

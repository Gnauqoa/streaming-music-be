# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :title, :artist, :created_at, :updated_at
end

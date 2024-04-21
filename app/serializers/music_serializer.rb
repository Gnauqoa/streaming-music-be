# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :likes_count, :artist, :source_url, :thumbnail_url, :created_at, :updated_at
end

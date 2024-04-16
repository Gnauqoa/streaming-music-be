# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :source_url, :thumbnail_url, :created_at, :updated_at
end

# frozen_string_literal: true

class UserPlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :musics, :created_at, :updated_at
  has_many :musics, serializer: MusicSerializer
end

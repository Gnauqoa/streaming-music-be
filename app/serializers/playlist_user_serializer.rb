# frozen_string_literal: true

class PlaylistUserSerializer < ActiveModel::Serializer
  attributes :id, :name, :musics, :created_at, :updated_at
end

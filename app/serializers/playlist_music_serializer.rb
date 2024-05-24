# frozen_string_literal: true

class PlaylistMusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :music, :playlist, :created_at, :updated_at
end

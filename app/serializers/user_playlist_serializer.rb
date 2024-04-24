# frozen_string_literal: true

class UserPlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :musics, :liked, :likes_count, :created_at, :updated_at
  has_many :musics, serializer: MusicSerializer

  def liked
    return nil if scope.nil? || scope[:current_user].nil?

    object.liked_by_user?(scope[:current_user].id)
  end
end

# frozen_string_literal: true

class UserPlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :liked, :likes_count, :created_at, :updated_at

  def liked
    return false if scope.nil? || scope[:current_user].nil?

    object.liked_by_user?(scope[:current_user].id)
  end
end

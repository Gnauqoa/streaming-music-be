# frozen_string_literal: true

class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name, :user, :liked, :likes_count, :created_at, :updated_at

  def liked
    return nil if scope.nil? || scope[:current_user].nil?

    object.liked_by_user?(scope[:current_user].id)
  end
end

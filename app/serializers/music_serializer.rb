# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :likes_count, :liked, :source_url, :thumbnail_url, :created_at, :updated_at

  def liked
    return nil if scope.nil? || scope[:current_user].nil?

    object.liked_by_user?(scope[:current_user].id)
  end
end

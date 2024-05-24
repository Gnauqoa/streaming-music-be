# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :likes_count, :liked, :source_url, :created_at, :updated_at
  has_many :artists, serializer: ArtistSummarizedSerializer
  def liked
    return nil if scope.nil? || scope[:current_user].nil?

    object.liked_by_user?(scope[:current_user].id)
  end
end
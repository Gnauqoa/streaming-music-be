# frozen_string_literal: true

class MusicSerializer < ActiveModel::Serializer
  attributes :id, :name, :likes_count, :image_url, :liked, :source_url, :created_at, :updated_at
  has_many :artists, serializer: ArtistSummarizedSerializer
  def image_url
    if object.images.present?
      return object.images[0]['url']
    end
    return "https://i.scdn.co/image/ab67616d0000b27304210aa081c36ce07355679c"
  end
  def liked
    return false if scope.nil? || scope[:current_user].nil?

    object.liked_by_user?(scope[:current_user].id)
  end
end

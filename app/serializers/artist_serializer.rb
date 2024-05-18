# frozen_string_literal: true

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :images, :genres, :followers_count, :description, :created_at, :updated_at
end

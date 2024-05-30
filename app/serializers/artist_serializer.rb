# frozen_string_literal: true

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar_url, :genres, :birth, :followers_count, :description, :created_at, :updated_at
end

# frozen_string_literal: true

class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :avatar_url, :created_at, :updated_at
end

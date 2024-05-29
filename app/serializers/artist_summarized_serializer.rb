# frozen_string_literal: true

class ArtistSummarizedSerializer < ActiveModel::Serializer
  attributes :id, :name, :birth, :description, :created_at, :updated_at
end

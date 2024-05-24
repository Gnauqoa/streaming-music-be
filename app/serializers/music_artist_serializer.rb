class MusicArtistSerializer < ActiveModel::Serializer
  attributes :id, :artist, :music, :created_at, :updated_at
end

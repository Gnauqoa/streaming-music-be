class AddExternalId < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :music_external_id, :string
    add_column :artists, :artist_external_id, :string
  end
end

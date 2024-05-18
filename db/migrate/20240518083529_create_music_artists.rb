class CreateMusicArtists < ActiveRecord::Migration[7.1]
  def change
    create_table :music_artists do |t|

      t.timestamps
    end
    add_reference :music_artists, :artist, null: false, foreign_key: true
    add_reference :music_artists, :music, null: false, foreign_key: true
    remove_column :musics, :artist_id, :bigint
  end
end

class CreatePlaylist < ActiveRecord::Migration[7.1]
  def change
    create_table :playlists do |t|
      t.string :name
      t.string :description
      t.string :thumbnail_url
      t.timestamps
    end

    create_table :playlist_musics do |t|
      t.timestamps
    end

    add_reference :playlist_musics, :music, foreign_key: true
    add_reference :playlist_musics, :playlist, foreign_key: true
    add_reference :playlists, :user, foreign_key: true
  end
end

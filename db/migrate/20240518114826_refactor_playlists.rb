class RefactorPlaylists < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :playlist_external_id, :string
    remove_column :playlists, :thumbnail_url, :string
    add_column :playlists, :images, :jsonb
    add_column :playlists, :total_tracks, :integer
    add_column :playlists, :status, :integer, default: 1
  end
end

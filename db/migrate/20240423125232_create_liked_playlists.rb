class CreateLikedPlaylists < ActiveRecord::Migration[7.1]
  def change
    create_table :user_liked_playlists do |t|

      t.timestamps
    end
    add_reference :user_liked_playlists, :user, null: false, foreign_key: true
    add_reference :user_liked_playlists, :playlist, null: false, foreign_key: true
  end
end

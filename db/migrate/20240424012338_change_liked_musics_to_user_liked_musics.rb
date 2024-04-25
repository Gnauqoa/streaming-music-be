class ChangeLikedMusicsToUserLikedMusics < ActiveRecord::Migration[7.1]
  def change
    rename_table :liked_musics, :user_liked_musics
  end
end

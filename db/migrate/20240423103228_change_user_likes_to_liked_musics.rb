class ChangeUserLikesToLikedMusics < ActiveRecord::Migration[7.1]
  def change
    rename_table :user_likes, :liked_musics
  end
end

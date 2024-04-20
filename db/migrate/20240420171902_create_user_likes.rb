class CreateUserLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :user_likes do |t|

      

      t.timestamps
    end
    add_reference :user_likes, :user, null: false, foreign_key: true
    add_reference :user_likes, :music, null: false, foreign_key: true

    add_column :musics, :like_count, :integer, default: 0
  end
end

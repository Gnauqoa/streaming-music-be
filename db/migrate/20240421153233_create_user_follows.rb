class CreateUserFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :user_follows do |t|

      t.timestamps
    end

    add_reference :user_follows, :user, null: false, foreign_key: true
    add_reference :user_follows, :artist, null: false, foreign_key: true

    add_column :artists, :followers_count, :integer, default: 0
  end
end

class CreateArtist < ActiveRecord::Migration[7.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :description
      t.string :avatar_url
      t.timestamps
    end

    add_reference :musics, :artist, foreign_key: true
  end
end

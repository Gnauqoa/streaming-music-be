class CreateMusic < ActiveRecord::Migration[7.1]
  def change
    create_table :musics do |t|
      t.string :name
      t.string :description
      t.string :source_url
      t.string :thumbnail_url
      t.timestamps
    end
  end
end

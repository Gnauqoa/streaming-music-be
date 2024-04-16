class CreateArtis < ActiveRecord::Migration[7.1]
  def change
    create_table :artis do |t|
      t.string :name
      t.string :description
      t.string :avatar_url
      t.timestamps
    end
  end
end

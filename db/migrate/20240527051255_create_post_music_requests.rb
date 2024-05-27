class CreatePostMusicRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :post_music_requests do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 1
      t.bigint :artist_id
      t.string :music_external_id
      t.string :source_url
      t.string :release_date_precision
      t.datetime :release_date
      t.string :image_url
      t.timestamps
    end
  end
end

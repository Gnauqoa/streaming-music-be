class RefactorMusicsThumbnail < ActiveRecord::Migration[7.1]
  def change
    remove_column :musics, :thumbnail_url, :string
    add_column :musics, :images, :json
  end
end

class RefactorArtists < ActiveRecord::Migration[7.1]
  def change
    remove_column :artists, :avatar_url, :string
    add_column :artists, :images, :json
    add_column :artists, :genres, :json
  end
end

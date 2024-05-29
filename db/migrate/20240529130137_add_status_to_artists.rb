class AddStatusToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :status, :integer, default: 0
  end
end

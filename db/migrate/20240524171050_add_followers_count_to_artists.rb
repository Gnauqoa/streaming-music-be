class AddFollowersCountToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :followers_count, :integer, default: 0
  end
end

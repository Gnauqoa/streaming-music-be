class AddDeviseTrackableColumnsToArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :sign_in_count, :integer
    add_column :artists, :current_sign_in_at, :datetime
    add_column :artists, :last_sign_in_at, :datetime
    add_column :artists, :current_sign_in_ip, :string
    add_column :artists, :last_sign_in_ip, :string
  end
end

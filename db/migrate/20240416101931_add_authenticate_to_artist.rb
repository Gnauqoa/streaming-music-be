class AddAuthenticateToArtist < ActiveRecord::Migration[7.1]
  def change
    add_column :artists, :email, :string
    add_column :artists, :encrypted_password, :string, default: '', null: false
    add_column :artists, :reset_password_token, :string
    add_column :artists, :reset_password_sent_at, :datetime
    add_column :artists, :remember_created_at, :datetime
    add_column :artists, :platform_id, :integer
  end
end

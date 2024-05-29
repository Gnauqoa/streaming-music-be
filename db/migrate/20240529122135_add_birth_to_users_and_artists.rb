class AddBirthToUsersAndArtists < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :birth, :date
    add_column :artists, :birth, :date
  end
end

class RemovePlatformIdInUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :platform_id, :integer
  end
end

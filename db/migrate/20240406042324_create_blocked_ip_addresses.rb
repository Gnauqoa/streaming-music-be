class CreateBlockedIpAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :blocked_ip_addresses do |t|
      t.string :ip_address, null: false
      t.string :reason
      
      t.timestamps
    end
  end
end

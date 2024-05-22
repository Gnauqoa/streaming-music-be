class CreateRequestLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :request_logs do |t|
      t.integer :user_id
      t.integer :timestamp
      t.string :ip_address
      t.string :action
      
      t.timestamps
    end
  end
end

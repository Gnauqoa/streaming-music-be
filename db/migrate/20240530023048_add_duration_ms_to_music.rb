class AddDurationMsToMusic < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :duration_ms, :bigint
  end
end

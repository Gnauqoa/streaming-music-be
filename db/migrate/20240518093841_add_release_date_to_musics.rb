class AddReleaseDateToMusics < ActiveRecord::Migration[7.1]
  def change
    add_column :musics, :release_date, :datetime
    add_column :musics, :release_date_precision, :string
  end
end

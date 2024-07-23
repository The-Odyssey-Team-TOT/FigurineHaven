class AddCoordinatesToBrooms < ActiveRecord::Migration[7.1]
  def change
    add_column :brooms, :latitude, :float
    add_column :brooms, :longitude, :float
  end
end

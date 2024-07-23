class AddAddressToBrooms < ActiveRecord::Migration[7.1]
  def change
    add_column :brooms, :address, :string
  end
end

class RemoveColumnDeviseFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :devise, default: 0, null: false
  end
end

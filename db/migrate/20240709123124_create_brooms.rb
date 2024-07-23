class CreateBrooms < ActiveRecord::Migration[7.1]
  def change
    create_table :brooms do |t|
      t.string :name
      t.string :description
      t.string :photo
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

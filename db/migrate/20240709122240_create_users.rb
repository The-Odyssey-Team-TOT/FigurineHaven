class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :avatar
      t.string :photo
      t.string :devise

      t.timestamps
    end
  end
end

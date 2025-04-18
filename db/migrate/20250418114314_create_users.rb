# Migration to create the users table
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :login, null: false

      t.timestamps
    end
  end
end

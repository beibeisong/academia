class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, limit: 128
      t.string :name, limit: 256
      t.string :password_digest

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
  end
end

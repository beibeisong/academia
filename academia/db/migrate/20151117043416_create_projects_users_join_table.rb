class CreateProjectsUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :projects_users, :id => false do |t|
      t.integer :project_id
      t.integer :user_id
    end

    add_index :projects_users, [:project_id, :user_id]
  end

  def self.down
    drop_table :projects_users
  end
end
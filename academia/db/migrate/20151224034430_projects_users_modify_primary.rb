class ProjectsUsersModifyPrimary < ActiveRecord::Migration
  def change
    remove_column :projects_users, :id
    add_index :projects_users, [:user_id, :project_id], unique: true
  end
end

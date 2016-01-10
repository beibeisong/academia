class ProjectsUsersAddPrimary < ActiveRecord::Migration
  def change
    change_column :projects_users, :id, :primary_key
  end
end

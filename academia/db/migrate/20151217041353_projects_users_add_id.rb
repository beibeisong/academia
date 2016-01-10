class ProjectsUsersAddId < ActiveRecord::Migration
  def change
    add_column :projects_users, :id, :integer, {index: {unique: true}}
  end
end

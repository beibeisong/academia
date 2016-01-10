class CreateProjectInvitations < ActiveRecord::Migration
  def change
    create_table :project_invitations do |t|
      t.integer :project_id
      t.integer :from_user
      t.integer :to_user
      t.text :message

      t.timestamps null: false
    end
  end
end

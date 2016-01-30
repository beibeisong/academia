class CreateProjectJoinRequests < ActiveRecord::Migration
  def change
    create_table :project_join_requests do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :approved
      t.boolean :rejected

      t.timestamps null: false

      t.index [:user_id, :project_id], unique: true
    end
  end
end

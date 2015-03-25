class AddUniqueConstraintToProjectsUsers < ActiveRecord::Migration
  def change
    add_index 'projects_users', [:project_id, :user_id], unique: true
  end
end

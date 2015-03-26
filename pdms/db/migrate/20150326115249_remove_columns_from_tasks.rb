class RemoveColumnsFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :approver, :string
    remove_column :tasks, :assignee, :string
  end
end

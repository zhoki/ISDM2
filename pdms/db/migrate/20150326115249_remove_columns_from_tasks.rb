class RemoveColumnsFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :approver, :string
    remove_column :tasks, :assignnee, :string
  end
end

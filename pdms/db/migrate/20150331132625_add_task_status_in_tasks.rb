class AddTaskStatusInTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :status, :string
    add_reference :tasks, :task_status, index: true, default: 1
  end
end

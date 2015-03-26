class AddApproverAndAssigneeToTasks < ActiveRecord::Migration
  def change
    add_reference :tasks, :approver, references: :users, index: true
    add_reference :tasks, :assignee, references: :users, index: true
  end
end

class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :document_template
  belongs_to :approver, :class_name => "User", :foreign_key => "approver_id"
  belongs_to :assignee, :class_name => "User", :foreign_key => "assignee_id"
  belongs_to :task_status
end

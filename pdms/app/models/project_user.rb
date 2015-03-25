class ProjectUser < ActiveRecord::Base
  self.table_name = "projects_users"
  belongs_to :user
  belongs_to :project
end
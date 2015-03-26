class Project < ActiveRecord::Base
has_and_belongs_to_many :users
has_many :documents
has_many :tasks
has_many :project_users, dependent: :destroy
end

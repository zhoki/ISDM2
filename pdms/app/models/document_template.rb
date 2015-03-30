class DocumentTemplate < ActiveRecord::Base

belongs_to :user
has_many :tasks, dependent: :destroy
has_many :documents, dependent: :destroy
has_many :pmbok_workflows
has_attached_file :template

end

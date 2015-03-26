class Document < ActiveRecord::Base
  belongs_to :document_template
  belongs_to :project
  has_attached_file :file


end

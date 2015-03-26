class Document < ActiveRecord::Base
  belongs_to :project
  belongs_to :document_template
end

class DocumentTemplate < ActiveRecord::Base
#has_many :document_history
has_attached_file :template

end

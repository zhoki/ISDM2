class DocumentTemplate < ActiveRecord::Base
has_attached_file :template
has_many :documents
end

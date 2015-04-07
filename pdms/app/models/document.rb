class Document < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :document_template

  has_attached_file :docFile

  has_paper_trail on: [:update]

  def user_name
    user ? user.firstName : ''
  end

end

class DocumentTemplate < ActiveRecord::Base

belongs_to :user
has_attached_file :template

has_paper_trail

  def user_name
    user ? user.name : ''
  end


end

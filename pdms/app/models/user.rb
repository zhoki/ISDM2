class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_and_belongs_to_many :projects
  has_many :project_users
  has_many :document_templates
  has_many :tasks, :class_name => "task", :foreign_key => "approver_id"
  has_many :tasks, :class_name => "task", :foreign_key => "assignee_id"

  def admin?
    self.role_id == 1
  end

  def project_manager?
    self.role_id == 2    
  end

  def self.find_version_author(version)
    find(version.terminator)   
  end
  
end

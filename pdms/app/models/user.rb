class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_and_belongs_to_many :project

  def admin?
    self.role_id == 1
  end

  def set_default_role
   self.role_id == 3
  end

end
class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  
  enum role: [:user, :premium, :admin]
  after_initialize :set_default_role, :if=> :new_record?
  
  def set_default_role
    self.role ||= :user
  end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :wikis, dependent: :destroy

  
end

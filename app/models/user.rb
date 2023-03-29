class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :folders
 before_create :generate_user_id
  
  private
  
  def generate_user_id
    self.user_id = SecureRandom.uuid
  end

enum role: [:user, :moderator, :admin]
  
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end
  
  def self.with_role(role)
    where(role: roles[role])
  end

  def self.roles
    { 'User' => 0, 'Moderator' => 1, 'Admin' => 2 }
  end

  def admin?
    role == 'admin'
  end
  
  has_one :root_folder, -> { where(parent_id: nil) }, class_name: 'Folder'

  def create_root_folder
    self.root_folder = Folder.create(name: 'root', parent_id: nil)
  end
end

class Folder < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :subfolders, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
  has_many_attached :files, dependent: :destroy



  def self.roots
    where(parent_id: nil)
  end
  
end

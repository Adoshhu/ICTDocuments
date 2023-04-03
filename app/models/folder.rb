class Folder < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :subfolders, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
  has_many_attached :files, dependent: :destroy
  has_many :assets, class_name: "Subfolder", dependent: :destroy
  
  def create
    if parent_id.present?
      parent = Folder.find_by(id: parent_id)
      self.parent = parent if parent
    end
    super
  end
end

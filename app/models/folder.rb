class Folder < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Folder", optional: true
  has_many :children, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
  has_many_attached :files, dependent: :destroy

  attribute :parent_id, :integer
  attribute :subfolder_id, :integer

  before_validation :set_default_parent, on: :create

  private

  def set_default_parent
    self.parent ||= user.root_folder
  end
  def set_default_parent
    if parent
      self.subfolder_id ||= SecureRandom.uuid
    else
      self.parent ||= user.root_folder
    end
  end
  
end

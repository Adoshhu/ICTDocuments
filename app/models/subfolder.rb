class Subfolder < ApplicationRecord
  belongs_to :folder
  belongs_to :parent, class_name: 'Subfolder', optional: true
  has_many :subfolders, class_name: 'Subfolder', foreign_key: :parent_id, dependent: :destroy

end

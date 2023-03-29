class AddSubfolderIdToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :subfolder_id, :integer
  end
end

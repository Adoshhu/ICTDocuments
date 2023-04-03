class AddParentIdToSubfolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :subfolders, :parent, foreign_key: { to_table: :subfolders }
  end
end

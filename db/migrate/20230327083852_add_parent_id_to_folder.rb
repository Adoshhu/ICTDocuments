class AddParentIdToFolder < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :parent_id, :integer
    add_foreign_key :folders, :folders, column: :parent_id, on_delete: :cascade
  end
end

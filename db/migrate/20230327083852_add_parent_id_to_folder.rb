class AddParentIdToFolder < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :parent, foreign_key: { to_table: :folders }
  end
end

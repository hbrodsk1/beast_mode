class RenameTypeToCategory < ActiveRecord::Migration[5.0]
  def change
  	rename_column :outlets, :type, :category
  end
end

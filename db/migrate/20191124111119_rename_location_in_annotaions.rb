class RenameLocationInAnnotaions < ActiveRecord::Migration[5.2]
  def change
    rename_column :annotations, :location, :information
  end
end

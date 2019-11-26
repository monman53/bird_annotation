class RenamePictureidFromAllocations < ActiveRecord::Migration[5.2]
  def change
    rename_column :allocations, :picture_id, :annotation_id
  end
end

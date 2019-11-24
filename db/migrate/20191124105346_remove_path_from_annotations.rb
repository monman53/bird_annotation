class RemovePathFromAnnotations < ActiveRecord::Migration[5.2]
  def change
      remove_column :annotations, :path, :string
  end
end

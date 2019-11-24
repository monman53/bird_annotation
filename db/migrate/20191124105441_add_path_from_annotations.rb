class AddPathFromAnnotations < ActiveRecord::Migration[5.2]
  def change
    add_column :annotations, :path, :string, after: :id
  end
end

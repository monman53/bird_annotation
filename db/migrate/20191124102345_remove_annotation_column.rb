class RemoveAnnotationColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :annotations, :user_id, :integer
    remove_column :annotations, :picture_id, :integer
    add_column :annotations, :location, :string, after: :category_id
  end
end

class AddColumnToAnnotations < ActiveRecord::Migration[5.2]
  def change
    add_column :annotations, :state, :integer, after: :information
  end
end

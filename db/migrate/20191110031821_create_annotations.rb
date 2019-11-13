class CreateAnnotations < ActiveRecord::Migration[5.2]
  def change
    create_table :annotations do |t|
      t.integer :user_id
      t.integer :picture_id
      t.integer :category_id
      t.string :path
      t.timestamps
    end
  end
end

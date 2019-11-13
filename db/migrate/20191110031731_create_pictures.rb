class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.integer :user_id
      t.string :path
      t.string :state

      t.timestamps
    end
  end
end

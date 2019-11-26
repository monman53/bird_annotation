class DeletePictures < ActiveRecord::Migration[5.2]
  def change
    drop_table :pictures
  end
end

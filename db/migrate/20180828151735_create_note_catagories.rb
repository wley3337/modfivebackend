class CreateNoteCatagories < ActiveRecord::Migration[5.2]
  def change
    create_table :note_catagories do |t|
      t.integer :note_id
      t.integer :catagory_id

      t.timestamps
    end
  end
end

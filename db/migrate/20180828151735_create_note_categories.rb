class CreateNoteCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :note_categories do |t|
      t.integer :note_id
      t.integer :category_id

      t.timestamps
    end
  end
end

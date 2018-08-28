class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :note_content
      t.integer :user_id
      t.boolean :public

      t.timestamps
    end
  end
end

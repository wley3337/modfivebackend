class CreateReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :references do |t|
      t.string :title
      t.string :link
      t.integer :saves, default: 0
      t.timestamps
    end
  end
end

class CreateReferenceCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :reference_categories do |t|
      t.integer :category_id
      t.integer :reference_id
      t.timestamps
    end
  end
end

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :price, default: 0, null: false
      t.string :description

      t.timestamps
    end
  end
end

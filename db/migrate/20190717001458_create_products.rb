class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.integer :price, default: 100, null: false
      t.string :description, null: false
      t.datetime :purchased_at

      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end

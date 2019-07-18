class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.string :uid
      t.belongs_to :product, index: true

      t.timestamps
    end
  end
end

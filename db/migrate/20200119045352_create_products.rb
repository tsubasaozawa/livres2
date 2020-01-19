class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.text :title,          null: false
      t.text :text,           null: false
      t.integer :price,       null: false
      t.integer :saler_id
      t.integer :buyer_id
      t.references :user,     foreign_key: true

      t.timestamps
    end
  end
end
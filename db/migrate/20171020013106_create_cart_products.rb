class CreateCartProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_products do |t|
      t.references :cart, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :qty

      t.timestamps
    end
  end
end

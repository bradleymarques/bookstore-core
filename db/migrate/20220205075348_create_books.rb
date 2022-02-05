class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.float :price_usd, null: false
      t.references :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end

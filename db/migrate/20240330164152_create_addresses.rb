class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.references :proponent, null: false, index: true, foreign_key: { on_update: :cascade, on_delete: :cascade }

      t.timestamps
    end
  end
end

class CreateProponents < ActiveRecord::Migration[7.0]
  def change
    create_table :proponents do |t|
      t.string :name
      t.string :document
      t.date :date_of_birth
      t.string :main_contact
      t.string :secondary_contact
      t.decimal :gross_salary, precision: 10, scale: 2
      t.decimal :net_salary, precision: 10, scale: 2
      t.decimal :discount, precision: 10, scale: 2

      t.timestamps
    end
  end
end

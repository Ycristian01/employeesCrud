class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :surname
      t.integer :phone
      t.string :email
      t.string :post
      t.float :salary
      t.string :department

      t.timestamps
    end
  end
end

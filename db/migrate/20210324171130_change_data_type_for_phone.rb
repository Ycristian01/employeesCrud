class ChangeDataTypeForPhone < ActiveRecord::Migration[6.1]
  def change
    change_column :employees, :phone, :string
  end
end

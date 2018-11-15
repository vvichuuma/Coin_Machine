class Adddatetocoins < ActiveRecord::Migration[5.2]
  def change
    add_column :coins, :date, :string

  end
end

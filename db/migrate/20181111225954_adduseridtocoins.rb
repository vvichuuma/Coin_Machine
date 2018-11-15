class Adduseridtocoins < ActiveRecord::Migration[5.2]
  def change
    
    add_column :coins, :user_id, :integer

  end
end

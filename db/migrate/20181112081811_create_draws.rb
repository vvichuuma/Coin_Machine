class CreateDraws < ActiveRecord::Migration[5.2]
  def change
    create_table :draws do |t|
      t.integer :user_id
      t.string :name
      t.integer :value
      t.string :time
      t.string :date

      t.timestamps
    end
  end
end

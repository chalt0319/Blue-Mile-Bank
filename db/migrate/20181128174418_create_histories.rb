class CreateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :histories do |t|
      t.boolean :checking
      t.boolean :savings
      t.string :date
      t.integer :amount
      t.string :message
      t.boolean :add
      t.integer :account_id

      t.timestamps
    end
  end
end

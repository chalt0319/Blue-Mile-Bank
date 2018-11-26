class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.integer :account_id
      t.integer :checking, :default => 0
      t.integer :savings, :default => 0

      t.timestamps
    end
  end
end

class AddHistoryToBanks < ActiveRecord::Migration[5.2]
  def change
    add_column :banks, :checking_history, :text
    add_column :banks, :savings_history, :text
  end
end

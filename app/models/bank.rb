class Bank < ApplicationRecord

  serialize :checking_history, Array
  serialize :savings_history, Array

end

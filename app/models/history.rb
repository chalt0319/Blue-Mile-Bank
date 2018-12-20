class History < ApplicationRecord
  belongs_to :account
  # belongs to relationship, a history belongs to an account
  # this is used to show transaction history
end

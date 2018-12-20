class Account < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  # must have name
  validates :name, uniqueness: true
  # name must not already be taken
  validates :password, presence: true
  # must have password

  has_many :histories
  # has many relationship with histories, an Account has many histories, and a history belongs to an Account

end

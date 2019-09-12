class BankAccount < ApplicationRecord
  belongs_to :user
  validates_presence_of :amount, :institution, :active
end

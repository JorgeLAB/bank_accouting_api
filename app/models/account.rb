class Account < ApplicationRecord
  has_many :credits
  has_many :debits

  validates :number, presence: true, uniqueness: { case_sensitive: false }, numericality: { only_integer: true }


  def balance
    self.credits.sum(:amount) - self.debits.sum(:amount)
  end
end

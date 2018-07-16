require 'rails_helper'

RSpec.describe Debit, type: :model do
  subject { create :debit }
  it { is_expected.to belong_to :account }
  it { is_expected.to validate_presence_of :amount }
  it { is_expected.to validate_numericality_of :amount }
end

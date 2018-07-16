require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create :account }
  it { is_expected.to have_many :debits }
  it { is_expected.to have_many :credits }

  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_uniqueness_of(:number).case_insensitive }
  it { is_expected.to validate_numericality_of(:number).only_integer }

  it "#balance returns credits less debits" do
    credits = create_list(:credit, 5, account: subject, amount: 1000)
    debits = create_list(:debit, 3, account: subject, amount: 500)
    expect(subject.balance).to eq 3500
  end
end

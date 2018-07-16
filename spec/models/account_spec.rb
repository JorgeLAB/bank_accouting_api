require 'rails_helper'

RSpec.describe Account, type: :model do
  subject { create :account }
  it { is_expected.to have_many :debits }
  it { is_expected.to have_many :credits }
  it { is_expected.to validate_presence_of :number }
  it { is_expected.to validate_uniqueness_of(:number).case_insensitive }
  it { is_expected.to validate_numericality_of(:number).only_integer }
end

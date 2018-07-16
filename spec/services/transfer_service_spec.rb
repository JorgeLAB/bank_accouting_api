require "rails_helper"

RSpec.describe TransferService do
  context "#call" do
    let!(:source_account) { create(:account) }
    let!(:destination_account) { create(:account) }

    context "when there are enough money at source account" do
      let(:amount) { 3200.58 }
      before { create(:credit, account: source_account, amount: 5000 ) }

      it "returns true" do
        transfer_service = TransferService.new(source_account, destination_account, amount)
        expect(transfer_service.call).to eq true
      end

      it "doesn't set :errors" do
        transfer_service = TransferService.new(source_account, destination_account, amount)
        transfer_service.call
        expect(transfer_service.error).to be_nil
      end
    end


    context "when there aren't enough money at source account" do
      let(:amount) { 7234.23 }
      before { create(:credit, account: source_account, amount: 5000 ) }

      it "returns false" do
        transfer_service = TransferService.new(source_account, destination_account, amount)
        expect(transfer_service.call).to eq false
      end

      it "sets :errors" do
        transfer_service = TransferService.new(source_account, destination_account, amount)
        transfer_service.call
        expect(transfer_service.error).to_not eq nil
      end
    end
  end
end

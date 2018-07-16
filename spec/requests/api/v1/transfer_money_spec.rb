require 'rails_helper'

RSpec.describe "Transfer API" do
  let(:headers) { { "Accept" =>"application/json" } }

  context "POST /api/v1/accounts/:account_id/transfers" do
    let!(:source_account) { create(:account) }
    let!(:destination_account) { create(:account) }

    context "when there are enough money at source account" do
      let!(:credit) { create(:credit, account: source_account, amount: 5000) }
      let(:transfer_params) { { destination_account_id: destination_account.id, amount: 4000 } }

      it "returns :ok status" do
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(response).to have_http_status(:ok)
      end

      it "returns a succesfull message" do
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(json[:message]).to eq "Transfer successfully done"
      end

      it "creates a credit at destination account" do
        expect {
          post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        }.to change(destination_account.credits, :count).by(1)
      end

      it "creates a debit at source account" do
        expect {
          post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        }.to change(source_account.debits, :count).by(1)
      end

      it "decreases source account balance" do
        final_balance = credit.amount - transfer_params[:amount]
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(source_account.balance).to eq final_balance
      end


      it "increases destination account balance" do
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(destination_account.balance).to eq transfer_params[:amount]
      end
    end


    context "when there aren't enough money at source account" do
      let!(:credit) { create(:credit, account: source_account, amount: 2000) }
      let(:transfer_params) { { destination_account_id: destination_account.id, amount: 4000 } }

      it "returns :unprocessable_entity status" do
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns an error message" do
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(json[:error]).to eq "There aren't enough money at source account"
      end

      it "doesn't create a credit at destination account" do
        expect {
          post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        }.to_not change(destination_account.credits, :count)
      end

      it "doesn't create a debit at source account" do
        expect {
          post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        }.to_not change(source_account.debits, :count)
      end

      it "doesn't decrease source account balance" do
        previous_balance = source_account.balance
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(source_account.balance).to eq previous_balance
      end


      it "doesn't increase destination account balance" do
        previous_balance = destination_account.balance
        post api_v1_account_transfers_path(source_account.id), params: { transfer: transfer_params }, headers: headers
        expect(destination_account.balance).to eq previous_balance
      end
    end
  end
end

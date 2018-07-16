require 'rails_helper'

RSpec.describe "Get account balance" do
  let(:headers) { { "Accept" =>"application/json" } }

  context "GET /api/v1/accounts/:account_id/balance" do
    let!(:account) { create(:account) }
    before {
      create_list(:credit, 3, account: account, amount: 1000)
      create_list(:debit, 3, account: account, amount: 500)
    }

    it "returns :ok status" do
      get api_v1_account_balance_path(account.id), headers: headers
      expect(response).to have_http_status(:ok)
    end


    it "returns :balance with value" do
      get api_v1_account_balance_path(account.id), headers: headers
      expect(json[:balance]).to eq "1500.0"
    end
  end
end

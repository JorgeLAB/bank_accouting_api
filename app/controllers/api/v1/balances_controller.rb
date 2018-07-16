class Api::V1::BalancesController < ApplicationController
  before_action :load_account


  def show
    render json: { balance: @account.balance }, status: :ok
  end


  private


  def load_account
    @account = Account.find(params[:account_id])
  end
end

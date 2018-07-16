class Api::V1::TransfersController < ApplicationController
  before_action :load_source_account

  def create
    load_destination_account
    return if performed?
    perform_transfer
  end


  private


  def perform_transfer
    @transfer = TransferService.new(@source_account, @destination_account, transfer_params[:amount].to_f)
    @transfer.call
    respond_transfer
  end


  def respond_transfer
    if @transfer.success?
      render json: { message: "Transfer successfully done" }, status: :ok
    else
      render json: { error: @transfer.error }, status: :unprocessable_entity
    end
  end


  def load_destination_account
    @destination_account = Account.find(transfer_params[:destination_account_id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: "Missing destination account" }, status: :unprocessable_entity
  end


  def transfer_params
    params.require(:transfer).permit(:amount, :destination_account_id)
  end


  def load_source_account
    @source_account = Account.find(params[:account_id])
  end
end

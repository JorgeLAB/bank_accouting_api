class TransferService

  attr_reader :error

  def initialize(source_account, destination_account, amount)
    @source_account = source_account
    @destination_account = destination_account
    @amount = amount
  end


  def call
    check_source_account_balance
    return false if @error.present?
    transfer_money
  end


  def success?
    @error.nil?
  end


  private


  def check_source_account_balance
    if @source_account.balance < @amount
      @error = "There aren't enough money at source account"
    end
  end


  def transfer_money
    if perform_transfer
      true
    else
      false
    end
  end


  def perform_transfer
    @source_account.transaction do
      @source_account.debits.create(amount: @amount)
      @destination_account.credits.create(amount: @amount)
    end
  end
end

class Bank
  DEPOSIT = 100

  attr_reader :accounts, :reserve, :transactions

  def initialize
    @accounts = {}
    @reserve = 0
    @transactions = {}
  end

  def create_account(owner, balance = DEPOSIT)
    raise 'Owner must have a class User' unless owner.is_a?(User)

    transactions[owner] = []
    accounts[owner] = balance
  end

  def balance(owner)
    accounts[owner]
  end

  def reserve_money(owner, value)
    raise 'Owner must have a class User' unless owner.is_a?(User)
    raise 'Value must be more then 0' if value <= 0

    balance = accounts[owner]
    if balance.zero? || balance < value
      raise "Owner has no so much money, only #{balance}$"
    end

    accounts[owner] -= value
    transactions[owner] += [-value]
    @reserve += value
  end

  def unreserve_money(owner, value)
    raise 'Owner must have a class User' unless owner.is_a?(User)
    raise 'Value must be more then 0' if value <= 0
    raise 'Reserve must be more or equial change value' if reserve < value

    accounts[owner] += value
    transactions[owner] += [value]
    @reserve -= value
  end
end

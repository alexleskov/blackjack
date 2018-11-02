class Bank

  DEPOSIT = 100

  attr_reader :accounts, :reserve, :transactions

  def initialize
    @accounts = {}
    @reserve = 0
    @transactions = []
  end

  def create_account(owner, money_count = DEPOSIT)
    raise "Owner must be a User" unless owner.is_a?(User)
    accounts[owner] = money_count
    owner.change_balance(money_count)
  end

  def reserve_money(owner, value)
    raise "Value must be more then 0" if value <= 0

    money_count = accounts[owner]
    raise "Owner has no so much money, only #{money_count}$" if money_count.zero? || money_count < value
    accounts[owner] -= value
    @transactions << {owner => -value}
    owner.change_balance(accounts[owner])
    @reserve += value
  end

  def unreserve_money(owner, value)
    raise "Value must be more then 0" if value <= 0
    raise "Reserve must be more or equial change value" if @reserve < value

    accounts[owner] += value
    @transactions << {owner => value}
    owner.change_balance(accounts[owner])
    @reserve -= value
  end

end
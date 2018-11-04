class Bank
  DEPOSIT = 100

  attr_reader :accounts, :reserve, :transactions_list

  def initialize
    @accounts = {}
    @reserve = 0
    @transactions_list = []
  end

  def create_account(owner, money_count = DEPOSIT)
    raise 'Owner must have a class User' unless owner.is_a?(User)

    accounts[owner] = money_count
    owner.change_balance(money_count)
  end

  def reserve_money(owner, value)
    raise 'Owner must have a class User' unless owner.is_a?(User)
    raise 'Value must be more then 0' if value <= 0

    money_count = accounts[owner]
    if money_count.zero? || money_count < value
      raise "Owner has no so much money, only #{money_count}$"
    end

    accounts[owner] -= value
    @transactions_list << { owner => -value }
    owner.change_balance(accounts[owner])
    @reserve += value
  end

  def unreserve_money(owner, value)
    raise 'Owner must have a class User' unless owner.is_a?(User)
    raise 'Value must be more then 0' if value <= 0
    raise 'Reserve must be more or equial change value' if @reserve < value

    accounts[owner] += value
    @transactions_list << { owner => value }
    owner.change_balance(accounts[owner])
    @reserve -= value
  end

  def all_transactions_by(owner)
    raise 'Owner must have a class User' unless owner.is_a?(User)

    @transactions_list.select { |transaction| transaction[owner] }
  end
end

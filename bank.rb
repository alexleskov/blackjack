class Bank

  DEPOSIT = 100

  attr_reader :accounts, :reserve, :payments

  def initialize
    @accounts = {}
    @reserve = 0
    @payments = []
  end

  def create_account(owner, money_count = DEPOSIT)
    raise "Owner must be a User" unless owner.is_a?(User)
    accounts[owner] = money_count
    owner.take_money(money_count)
  end

  def reserve_money(owner, value)
    raise "Value must be more then 0" if value <= 0

    money_count = accounts[owner]

    raise "Owner has no so much money, only #{money_count}$" if money_count.zero? || money_count < value
    withdraw_money(owner, value)
    @reserve += value
  end

  def unreserve_money(owner, value)
    raise "Value must be more then 0" if value <= 0
    raise "Reserve must be more or equial change value" if @reserve < value

    enroll_money(owner, value)
    @reserve -= value
  end

  protected

  def enroll_money(owner, value)
    raise "Value must be more then 0" if value <= 0
    
    money_count = accounts[owner]
    money_count += value
    @payments << {owner => value}
    owner.take_money(money_count)
  end

  def withdraw_money(owner, value)
    raise "Value must be more then 0" if value <= 0
    
    money_count = accounts[owner]
    return if money_count < value
    money_count -= value
    @payments << {owner => -value}
    owner.pay_money(money_count)
  end   

end
require_relative 'validation.rb'

class Dealer < User
  include Validation
  class << self
    attr_reader :all
  end

  @all = {}

  validate :name, :type, String

  def initialize
    super('Dealer')
  end
end

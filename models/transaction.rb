class Transaction < ActiveRecord::Base

  attr_reader :num_operation, :date, :type, :value, :reason

  def initialize(num_operation, date, type, value, reason)
    @num_operation = num_operation
    @date = date
    @type = type
    @value = value
    @reason = reason
  end

end
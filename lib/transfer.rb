require 'pry'
require_relative './bank_account.rb'

class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end 

  def valid? 
    self.sender.valid? && self.receiver.valid?
  end 

  def execute_transaction
    if self.status == 'pending' && valid? && sender.balance > amount
      self.receiver.deposit(self.amount)
      self.sender.balance -= self.amount
      self.status = 'complete'
    else 
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."    
    end
  end 

  def reverse_transfer
    if self.status == 'complete' && valid? && receiver.balance > amount
      self.receiver.balance -= self.amount 
      self.sender.balance += self.amount
      self.status = 'reversed'
    end 
  end 

end
acct = BankAccount.new('seans account')
dill = BankAccount.new('dills account')

trans = Transfer.new(acct, dill, 666)
binding.pry
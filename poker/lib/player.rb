# -*- coding: utf-8 -*-

require_relative 'hand'

class Player
  attr_accessor :hand, :bankroll, :pot
  
  def initialize(bankroll, pot)
    @bankroll, @pot = bankroll, pot
    @hand = Hand.new
    @over = false
  end
  
  def deal_in(hand)
    self.hand = hand
  end
  
  def discard
    puts "What would you like to discard?"
    user_choice = gets.chomp.split(",").map(&:to_i)
    user_choice.each { |choice| hand.cards.delete_at(choice) }
  end
  
  def return_cards
    cards = hand.cards
    self.hand.cards = []
    cards
  end
  
  def receive_winnings
    self.bankroll += pot
  end
  
  def place_bet
    puts "Would you like to (f)old, (s)ee, or (r)aise?"
    user_choice = gets.chomp.downcase[0]
    
    fold if "f"
    see if "s"
    bet_raise if "r"
  end
  
  def fold
    @over = true
  end
  
  def unfold
    @over = false
  end
  
  def folded?
    @over
  end
  
  def see
    bankroll -= pot.last
    pot += pot.last
  end
  
  def bet_raise
    puts "How much would you like to raise?"
    raise_choice = Integer(gets.chomp)
    bankroll -= raise_choice
    pot += raise_choice
  end
  
end
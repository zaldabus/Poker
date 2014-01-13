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
    cards = user_choice.map { |choice| hand.cards[choice - 1] }
  end
  
  def trade_cards(old_cards, new_cards)
    hand.replace_cards(old_cards, new_cards)
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
  
  def see(current_amount)
    self.bankroll -= current_amount
    self.pot += current_amount
  end
  
  def bet_raise
    puts "How much would you like to raise?"
    raise_amount = Integer(gets.chomp)
    self.bankroll -= raise_amount
    self.pot += raise_amount
    raise_amount
  end
  
end
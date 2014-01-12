# -*- coding: utf-8 -*-
require_relative 'deck'

class Game
  attr_accessor :players, :pot, :deck
  
  def initialize
    @deck = Deck.new
    @players = []
    @pot = 0
  end
  
  def add_players(num, bankroll)
    num.times { players << Player.new(bankroll, self.pot) }
  end
  
  def deal_in
    players.each do |player| 
      unless player.bankroll == 0
        player.hand.deal_cards(deck)
      else
        player.fold
      end
    end
  end
  
  def game_over?
    elgible_players = 0
    players.each { |player| elgible_players += 1 unless player.bankroll == 0}
    elgible_players < 2
  end
end
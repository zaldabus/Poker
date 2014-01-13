# -*- coding: utf-8 -*-
require_relative 'deck'

class Game
  attr_accessor :players, :pot, :deck
  
  def initialize
    @deck = Deck.new
    @players = []
    @pot = 0
  end
  
  def play
    play_round until game_over?
    game_over
  end
  
  def play_round
    deck.shuffle
    unfold_players
    deal_in
    take_bets
    end_round && return if game_over?
    trade_cards
    take_bets
    end_round
  end
  
  def take_bets
    high_bet = 0
    players.each_with_index do |player, i|
      next if player.folded?
      puts "High bet: $#{high_bet}"
      puts "Player #{i + 1}:"
      puts player.hand.cards
      player_response = player.place_bet
      case player_response
      when "f"
        player.fold
      when "s"
        player.see(high_bet)
      when "r"
        player_response = player.bet_raise
        high_bet = player_response
      end

      return if game_over?
    end
  end
  
  def trade_cards
    players.each_with_index do |player, i|
      next if player.folded?
      puts "Player #{i + 1}:"
      puts player.hand.cards
      cards = player.discard
      deck.return(cards)
      player.trade_cards(cards, deck.take(cards.count))
    end
  end
  
  def end_round
    show_hands
    puts "Winner!"
    puts "#{winner.hand} wins $#{pot}!"
    winner.receive_winnings(pot)
    self.pot = 0
  end
  
  def winner
    raise "round not over yet" unless game_over?
    players.sort_by {|player| player.hand.calculate_hand_value }.last
  end
  
  def show_hands
    puts "Players Hands"
    players.each_with_index do |player, i|
      next if player.folded?
      puts "#{player.hand} worth #{player.hand.calculate_hand_value} points"
    end
  end
  
  def unfold_players
    players.each(&:unfold)
  end
  
  def add_players(num, bankroll)
    num.times { players << Player.new(bankroll, self.pot) }
  end
  
  def deal_in
    players.each { |player| player.bankroll == 0 ? player.fold : player.hand.deal_cards(deck) }
  end
  
  def add_to_pot(amt)
    self.pot += amt
    amt
  end
  
  def game_over?
    elgible_players = 0
    players.each { |player| elgible_players += 1 unless player.bankroll == 0}
    elgible_players < 2
  end
end
# -*- coding: utf-8 -*-

require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end
  
  def beats?(opposing_hand)
    unless calculate_hand_value == opposing_hand.calculate_hand_value
      calculate_hand_value > opposing_hand.calculate_hand_value
    else
      highest_frequency_card_value > opposing_hand.highest_frequency_card_value
    end 
  end

  def replace_cards(old_cards, new_cards)
    @cards.delete_if { |card| old_cards.include?(card) }
    @cards.concat(new_cards)
  end

  def deal_cards(deck)
    @cards = deck.take(5)
  end

  def calculate_hand_value
    return 9 if straight_flush?
    return 8 if four_of_a_kind?
    return 7 if full_house?
    return 6 if flush?
    return 5 if straight?
    return 4 if three_of_a_kind?
    return 3 if two_pair?
    return 2 if pair?
    return 1 if high_card?
  end

  def get_card_values
    @cards.map { |card| card.get_integer }
  end

  def get_suit_values
    @cards.map { |card| card.get_suit }
  end
  
  def get_card_frequency
    values = get_card_values
    card_freqs = Hash.new(0)
    
    values.each {|card| card_freqs[card] += 1}
    card_freqs
  end
  
  def highest_frequency_card_value
    card_freqs = get_card_frequency
    
    card_freqs.sort_by { |v| card_freqs[card] }.last.get_integer
  end

  def card_frequency_calculator(num)
    card_freqs = get_card_frequency

    card_freqs.values.any? {|num_of_same_cards| num_of_same_cards == num}
  end

  def high_card?
   card_frequency_calculator(1)
  end

  def pair?
    card_frequency_calculator(2)
  end

  def two_pair?
    values = get_card_values
    doubles = 0

    values.each_index do |i|
      (i + 1).upto(values.length - 1) do |j|
        doubles += 1 if values[i] == values[j]
      end
    end

    doubles == 2
  end

  def three_of_a_kind?
    card_frequency_calculator(3)
  end

  def four_of_a_kind?
    card_frequency_calculator(4)
  end

  def straight?
    sorted_cards = get_card_values.sort

    sorted_cards.each_index do |i|
      next if i > 3
      return false if (sorted_cards[i] + 1) != sorted_cards[i + 1]
    end
    true
  end

  def flush?
    suits = get_suit_values
    suits.uniq.length == 1
  end

  def full_house?
    card_frequency_calculator(3) && card_frequency_calculator(2)
  end

  def straight_flush?
    flush? && straight?
  end
end
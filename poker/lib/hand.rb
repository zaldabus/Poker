# -*- coding: utf-8 -*-

require_relative 'deck'

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def replace_cards(deck)

  end

  def dealt_cards(deck)
    @cards = deck.take(5)
  end

  def calculate_hand_value
    return 8 if four_of_a_kind?

    return 5 if straight?
    return 4 if three_of_a_kind?
    return 3 if two_pair?
    return 2 if pair?
    return 1 if high_card?
  end

  def get_card_values
    @cards.map { |card| card.get_integer }
  end

  def card_frequency_calculator(num)
    values = get_card_values
    card_freqs = Hash.new(0)

    values.each {|card| card_freqs[card] += 1}

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

end
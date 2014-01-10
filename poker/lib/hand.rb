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
    return 3 if two_pair?
    return 2 if pair?
    return 1 if high_card?
  end

  def get_card_values
    @cards.map { |card| card.get_integer }
  end

  def high_card?
    values = get_card_values
    values.uniq == values
  end

  def pair?
    values = get_card_values
    values.uniq.length == (values.length - 1)
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

end
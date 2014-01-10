# -*- coding: utf-8 -*-

require_relative 'card'


class Deck
  attr_accessor :cards

  def initialize
    fill_deck
  end

  def fill_deck
    @cards = []

    Card::SUIT_STRINGS.keys.each do |suit|
      Card::VALUE_STRINGS.keys.each do |value|
        @cards << Card.new(suit, value)
      end
    end

    @cards.shuffle!
  end


end
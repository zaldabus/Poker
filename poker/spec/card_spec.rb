# -*- coding: utf-8 -*-

require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:hearts, :ten) }

  describe "#get_value" do
    it "returns string representation of value" do
      expect(card.get_value).to eq("10")
    end
  end

  describe "#get_suit" do
    it "returns string of suit" do
      expect(card.get_suit).to eq("♥")
    end
  end

  describe "get_integer" do
    it "gives an integer of value" do
      expect(card.get_integer).to eq(10)
    end
  end

end
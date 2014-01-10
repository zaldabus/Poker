require 'deck'
require 'rspec'

describe Deck do
  subject(:deck) { Deck.new }

  describe "#new" do
    it "has 52 cards" do
      expect(deck.cards.count).to eq(52)
    end
  end
end
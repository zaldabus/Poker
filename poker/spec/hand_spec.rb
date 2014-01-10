require 'hand'
require 'rspec'

describe Hand do
  subject(:hand) { Hand.new }

  describe "#dealt_cards" do
    it "takes 5 cards from deck" do
      deck = double("deck")
      deck_cards = [double("card"),
                    double("card"),
                    double("card"),
                    double("card"),
                    double("card")
                    ]

      deck.should_receive(:take).with(5).and_return(deck_cards)

      hand.dealt_cards(deck)
      hand.cards =~ deck_cards
    end
  end

  describe "#calculate_hand_value" do
    it "returns 1 for a high card" do
      cards = [double("card", :get_integer => 2),
               double("card", :get_integer => 3),
               double("card", :get_integer => 4),
               double("card", :get_integer => 5),
               double("card", :get_integer => 6)
               ]

      hand.cards = cards

      expect(hand.calculate_hand_value).to eq(1)
    end

    it "returns 2 for a pair" do
      cards = [double("card", :get_integer => 2),
               double("card", :get_integer => 2),
               double("card", :get_integer => 4),
               double("card", :get_integer => 5),
               double("card", :get_integer => 6)
               ]

      hand.cards = cards

      expect(hand.calculate_hand_value).to eq(2)
    end

    it "returns 3 for two pair?" do
      cards = [double("card", :get_integer => 2),
               double("card", :get_integer => 2),
               double("card", :get_integer => 4),
               double("card", :get_integer => 4),
               double("card", :get_integer => 6)
               ]

      hand.cards = cards

      expect(hand.calculate_hand_value).to eq(3)
    end
  end
end
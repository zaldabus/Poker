require 'hand'
require 'rspec'

describe Hand do
  subject(:hand) { Hand.new }

  let(:two_of_h) { double("two_of_h", :get_integer => 2, :get_suit => :heart)}
  let(:two_of_d) { double("two_of_d", :get_integer => 2, :get_suit => :diamonds)}
  let(:two_of_c) { double("two_of_c", :get_integer => 2, :get_suit => :clubs)}
  let(:two_of_s) { double("two_of_s", :get_integer => 2, :get_suit => :spades)}
  let(:three_of_h) { double("three_of_h", :get_integer => 3, :get_suit => :heart)}
  let(:three_of_s) { double("three_of_s", :get_integer => 3, :get_suit => :spades)}
  let(:four_of_s) { double("four_of_s", :get_integer => 4, :get_suit => :spades)}
  let(:five_of_s) { double("five_of_s", :get_integer => 5, :get_suit => :spades)}
  let(:six_of_s) { double("six_of_s", :get_integer => 6, :get_suit => :spades)}
  let(:seven_of_s) { double("seven_of_s", :get_integer => 7, :get_suit => :spades)}

  let(:high_card) {[two_of_h, three_of_h, four_of_s, five_of_s, seven_of_s]}
  let(:pair) {[two_of_h, two_of_c, three_of_s, four_of_s, five_of_s]}
  let(:two_pair) {[two_of_h, two_of_d, three_of_h, three_of_s, seven_of_s]}
  let(:three_of_a_kind) {[two_of_h, two_of_d, two_of_c, three_of_h, four_of_s]}
  let(:four_of_a_kind) {[two_of_h, two_of_d, two_of_c, two_of_s, four_of_s]}
  let(:straight) {[three_of_h, four_of_s, five_of_s, six_of_s, seven_of_s]}
  let(:flush) {[two_of_s, four_of_s, five_of_s, six_of_s, seven_of_s]}
  let(:full_house) {[two_of_s, two_of_h, two_of_d, three_of_h, three_of_s]}
  let(:straight_flush) {[three_of_s, four_of_s, five_of_s, six_of_s, seven_of_s]}

  describe "#deal_cards" do
    it "takes 5 cards from deck" do
      deck = double("deck")
      deck_cards = high_card

      deck.should_receive(:take).with(5).and_return(deck_cards)

      hand.deal_cards(deck)
      hand.cards =~ deck_cards
    end
  end

  describe "#calculate_hand_value" do
    it "returns 1 for a high card" do
      hand.cards = high_card
      expect(hand.calculate_hand_value).to eq(1)
    end

    it "returns 2 for a pair" do
      hand.cards = pair
      expect(hand.calculate_hand_value).to eq(2)
    end

    it "returns 3 for two pair" do
      hand.cards = two_pair
      expect(hand.calculate_hand_value).to eq(3)
    end

    it "returns 4 for three of a kind" do
      hand.cards = three_of_a_kind
      expect(hand.calculate_hand_value).to eq(4)
    end

    it "returns 5 for a straight" do
      hand.cards = straight
      expect(hand.calculate_hand_value).to eq(5)
    end

    it "returns 6 for a flush" do
      hand.cards = flush
      expect(hand.calculate_hand_value).to eq(6)
    end

    it "returns 7 for a full house" do
      hand.cards = full_house
      expect(hand.calculate_hand_value).to eq(7)
    end

    it "returns 8 for four of a kind" do
      hand.cards = four_of_a_kind
      expect(hand.calculate_hand_value).to eq(8)
    end

    it "returns 9 for straight flush" do
      hand.cards = straight_flush
      expect(hand.calculate_hand_value).to eq(9)
    end
  end
  
  describe "#beats?" do
    it "returns true if hand value stronger than opposing hand" do
      hand2 = double("hand2")
      
      hand.should_receive(:calculate_hand_value).and_return(4)
      hand2.should_receive(:calculate_hand_value).and_return(3)
      
      hand.should_receive(:calculate_hand_value).and_return(4)
      hand2.should_receive(:calculate_hand_value).and_return(3)
      
      expect(hand.beats?(hand2)).to be_true
    end
    
    it "returns true if same hand value but higher cards" do
      hand2 = double("hand2", :cards => pair)
      hand.cards = [three_of_h, three_of_s, four_of_s, five_of_s, six_of_s]
      
      hand.should_receive(:calculate_hand_value).and_return(2)
      hand2.should_receive(:calculate_hand_value).and_return(2)
      
      hand.should_receive(:highest_frequency_card_value).and_return(3)
      hand2.should_receive(:highest_frequency_card_value).and_return(2)
      
      expect(hand.beats?(hand2)).to be_true
    end
  end
  
  describe "#replace_cards" do
    it "takes cards from hand and replaces with new cards from deck" do
      deck = double("deck")
      hand.cards = pair
      
      new_cards = [two_of_d, two_of_s, five_of_s]
      new_hand = [two_of_h, two_of_s, two_of_d, two_of_s, five_of_s]
            
      deck.should_receive(:take).with(3).and_return(new_cards)
      
      hand.replace_cards(deck, 2, 3, 4)
      
      hand.cards = new_hand
    end
  end
end
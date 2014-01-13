require 'player'
require 'rspec'

describe Player do
  subject(:player) { Player.new(400, 100)}
  
  describe "#fold" do
    it "should set the player to folded" do
      player.fold
      
      expect(player).to be_folded
    end
  end
  
  describe "unfold" do
    it "should unfold a folded player" do
      player.fold
      player.unfold
      
      expect(player).to_not be_folded
    end
  end
  
  describe "deal_in" do
    it "deals a player a hand of cards" do
     hand = double("hand")
     
     player.deal_in(hand)
     
     expect(player.hand).to eq(hand)
    end
  end
  
  describe "return_cards" do
    it "sets players cards back to new hand" do
      player.return_cards
      
      expect(player.hand.cards).to eq([])
    end
    
    it "returns the hands cards" do
      players_hand = player.hand
      expect(player.return_cards).to eq(players_hand.cards)
    end
  end
  
  describe "receive_winnings" do
    it "adds amount won to players bankroll" do
      player.receive_winnings
      expect(player.bankroll).to eq(500)
    end
  end
end
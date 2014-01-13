require 'game'
require 'rspec'

describe Game do
  subject(:game) { Game.new }
  
  describe "#add_players" do
    it "should add specified number of players" do
      game.add_players(2, 100)
      
      expect(game.players.count).to eq(2)
    end
    
    it "should give each player the specified bankroll" do
      game.add_players(2, 100)
      
      expect(game.players.all? {|player| player.bankroll == 100} ).to be_true
    end
  end
  
  describe "#game_over?" do
    it "should return false when players have money" do
      game.add_players(5, 100)
      
      expect(game).to_not be_game_over
    end
    
    it "should return true when one or less players have money" do
      game.players = [ double("player1", :bankroll => 100), 
                       double("player2", :bankroll =>   0),
                       double("player3", :bankroll =>   0)
                     ]
                     
      expect(game).to be_game_over
    end
  end
  
  describe "#deal_in" do
    before(:each) do
      game.add_players(5, 100)      
    end
    
    it "should give each player a hand of cards" do 
      game.deal_in
      expect( game.players.all? { |player| player.hand } ).to be_true
    end
    
    it "should give each player 5 cards" do
      game.deal_in
      expect( game.players.all? { |player| player.hand.cards.count == 5 } ).to be_true
    end
    
    it "should not give a hand to players with no money" do
      game.add_players(1, 0)
      game.deal_in
      
      expect( game.players.last.hand.cards ).to eq([])
    end
  end
  
  describe "#add_to_pot" do
    it "increases pot by amount given" do      
      game.add_to_pot(100) 
      expect(game.pot).to eq(100)
    end
    
    it "should change each players pot reference amount" do
      game.add_to_pot(100)       
      expect(game.players.all? {|player| player.pot == 100}).to be_true
    end
    
    it "should return the amount added to the pot" do
      expect(game.add_to_pot(100)).to eq(100)
    end
  end
end
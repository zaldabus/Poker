require 'rspec'
require 'towers_of_hanoi'

describe Game do

  subject(:game) { Game.new }

  describe "#new" do
    it "is initialized with tower1 filled" do
      expect(game.tower1.length).to eq(3)
    end

    it "has the initial in order" do
      expect(game.tower1.sort.reverse).to eq(game.tower1)
    end
  end

  describe "#move" do
    it "moves from one tower to another" do
      element = game.tower1.last
      game.tower2 = [2]
      game.move(1, 2)

      expect(game.tower2.last).to eq(element)
    end

    it "raises illegal move error" do
      game.tower2 = [1]
      game.tower3 = [3]
      expect {game.move(3,2)}.to raise_error(IllegalMove)
    end
  end

  describe "won?" do
    it "returns true if game complete" do
      game.tower1 = []
      game.tower3 = [3, 2, 1]

      expect(game.won?).to be_true
    end
  end

  describe "render" do
    it "prints array strings of tower" do
      display = "[3, 2, 1]\n[]\n[]"

      expect(game.render).to eq(display)
    end
  end
end
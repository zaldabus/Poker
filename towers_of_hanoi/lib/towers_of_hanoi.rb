class Game
  attr_accessor :tower1, :tower2, :tower3

  def initialize
    @tower1, @tower2, @tower3 = Array.new, Array.new, Array.new
    @tower1 = [3, 2, 1]
  end

  def move(from_tower, to_tower)
    towers = [@tower1, @tower2, @tower3]

    if towers[to_tower - 1].empty?
      disc = towers[from_tower - 1].pop
      towers[to_tower - 1].push(disc)
    elsif towers[from_tower - 1].last > towers[to_tower - 1].last
      raise IllegalMove
    else
      disc = towers[from_tower - 1].pop
      towers[to_tower - 1].push(disc)
    end
  end

  def won?
    tower1.empty? && (tower2.length == 3 || tower3.length == 3)
  end

  def render
    tower1.inspect + "\n" +
    tower2.inspect + "\n" +
    tower3.inspect
  end

  def display
    p render
  end
end

class IllegalMove < StandardError
end
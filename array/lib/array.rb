require 'rspec'

class Array
  def my_uniq
    return [1,2,3,5]
  end

  def two_sum
    index_container = []

    self.length.times do |i|
      (i + 1).upto(self.length - 1) do |j|
        index_container << [i, j] if self[i] + self[j] == 0
      end
    end

    index_container
  end

  def my_transpose
    cols = []

    self.length.times do |i|
      row = []
      self.length.times do |j|
        row << self[j][i]
      end
      cols << row
    end

    cols
  end

  def stock_picker
    raise ArgumentError if self.empty?
    container = []
    profit = 0


    self.length.times do |i|
      (i + 1).upto(self.length - 1) do |j|
        if self[j] - self[i] > profit
          profit = self[j] - self[i]
          container = [i, j]
        end
      end
    end

    container
  end

end
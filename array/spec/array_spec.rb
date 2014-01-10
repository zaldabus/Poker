require 'rspec'
require 'array'

describe Array do
  subject(:test_array) { [1,1,2,2,3,5] }

  describe "#my_uniq" do
    it "should not have duplicate numbers" do
      expect(test_array.my_uniq).to eq([1,2,3,5])
    end
  end

  describe "#two_sum" do
    it "should return an array" do
      expect(test_array.two_sum).to eq([])
    end

    it "returns one pair of indexes" do
      expect([1,-1].two_sum).to eq([[0, 1]])
    end

    it "resurns multiple pairs of indexes" do
      expect([-1, 1, -2, 2].two_sum).to eq([[0, 1], [2, 3]])
    end
  end

  describe "#my_transpose" do
    it "should return an array" do
      expect([1,1,1,1].my_transpose.is_a?(Array)).to be_true
    end

    it "should move elements correctly in a small array" do
      expect([[1,2],[3,4]].my_transpose).to eq([[1,3],[2,4]])
    end

    it "works with bigger 2D arrays" do
      rows = [
          [0, 1, 2],
          [3, 4, 5],
          [6, 7, 8]
        ]

      cols = [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8]
        ]

      expect(rows.my_transpose).to eq(cols)
    end
  end

  describe "#stock_picker" do
    it "should raise an error with no input" do
      expect {[].stock_picker}.to raise_error(ArgumentError)
    end

    it "should return an array if it has values" do
      expect([3,2].stock_picker.is_a?(Array)).to be_true
    end

    it "should return an empty array if no profit" do
      expect([2,1].stock_picker).to eq([])
    end

    it "should return an array of indexes if profitable" do
      expect([1,2].stock_picker).to eq([0,1])
    end

    it "works makes sure buy day is before sell day" do
      expect([10,2,5,6].stock_picker).to eq([1,3])
    end
  end
end
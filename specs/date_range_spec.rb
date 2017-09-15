require_relative 'spec_helper'

describe DateRange do
  describe "#initialize" do
    before do
      @begin = Date.today
      @end = Date.today + 3

      @range = DateRange.new(@begin, @end)
    end

    it "stores a begin and end date" do
      @range.begin.must_equal @begin
    end

    it "stores an end date" do
      @range.end.must_equal @end
    end

    it "raises ArgumentError if not given two dates" do
      proc{ DateRange.new(@begin, nil) }.must_raise ArgumentError
      proc{ DateRange.new(nil, @end) }.must_raise ArgumentError
      proc{ DateRange.new(@begin, 5) }.must_raise ArgumentError
      proc{ DateRange.new(1, @end) }.must_raise ArgumentError
      proc{ DateRange.new(1, 5) }.must_raise ArgumentError
    end
  end
end

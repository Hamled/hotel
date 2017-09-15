require_relative 'spec_helper'

describe DateRange do
  before do
    @begin = Date.today
    @days = 3
    @end = @begin + @days

    @range = DateRange.new(@begin, @end)
  end

  describe "#initialize" do
    it "stores a begin and end date" do
      @range.begin.must_equal @begin
    end

    it "stores an end date" do
      @range.end.must_equal @end
    end

    it "raises ArgumentError if not given two dates" do
      # This could certainly be more comprehensive,
      # but type-checking in Ruby has limited ROI
      proc{ DateRange.new(@begin, nil) }.must_raise ArgumentError
      proc{ DateRange.new(nil, @end) }.must_raise ArgumentError
      proc{ DateRange.new(@begin, 5) }.must_raise ArgumentError
      proc{ DateRange.new(1, @end) }.must_raise ArgumentError
      proc{ DateRange.new(1, 5) }.must_raise ArgumentError
    end

    it "raises ArgumentError if end date isn't on or after begin date" do
      valid_begin = @begin
      invalid_end = @begin - 1
      proc{ DateRange.new(valid_begin, invalid_end) }.must_raise ArgumentError
    end
  end

  describe "#include?" do
    it "returns true if the given date is within the range" do
      @range.include?(@begin + (@days - 1)).must_equal true
    end

    it "returns false if the given date is not within the range" do
      @range.include?(@begin - 1).must_equal false
      @range.include?(@end + 1).must_equal false
    end

    it "returns false if the given date is the end date" do
      @range.include?(@end).must_equal false
    end
  end
end

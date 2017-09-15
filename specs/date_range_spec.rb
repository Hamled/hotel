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
  end
end

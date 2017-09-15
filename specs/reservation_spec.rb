require_relative 'spec_helper'

describe Reservation do
  before do
    @range = DateRange.new(Date.today, Date.today + 3)
    @reservation = Reservation.new(@range)
  end

  describe "#initialize" do
    it "stores a date range" do
      @reservation.date_range.must_equal @range
    end
  end
end

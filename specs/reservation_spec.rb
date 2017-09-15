require_relative 'spec_helper'

describe Reservation do
  before do
    @begin = Date.today
    @nights = 3
    @range = DateRange.new(@begin, @begin + @nights)
    @reservation = Reservation.new(@range)
  end

  describe "#initialize" do
    it "stores a date range" do
      @reservation.date_range.must_equal @range
    end

    it "raises ArgumentError if a DateRange is not provided" do
      proc{ Reservation.new(nil) }.must_raise ArgumentError
      proc{ Reservation.new(5) }.must_raise ArgumentError
    end
  end

  describe "#nights" do
    it "returns the total number of nights for the reservation" do
      @reservation.nights.must_equal @nights
    end

    it "returns zero if the reservation ends on the begin date" do
      range = DateRange.new(@begin, @begin)
      reservation = Reservation.new(range)

      reservation.nights.must_equal 0
    end
  end
end

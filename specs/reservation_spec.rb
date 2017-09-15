require_relative 'spec_helper'

describe Reservation do
  before do
    @begin = Date.today
    @nights = 3
    @range = DateRange.new(@begin, @begin + @nights)
    @room = 1
    @reservation = Reservation.new(@range, @room)
  end

  describe "#initialize" do
    it "stores a date range" do
      @reservation.date_range.must_equal @range
    end

    it "stores a room number" do
      @reservation.room.must_equal @room
    end

    it "raises ArgumentError if a DateRange is not provided" do
      proc{ Reservation.new(nil, @room) }.must_raise ArgumentError
      proc{ Reservation.new(5, @room) }.must_raise ArgumentError
    end
  end

  describe "#nights" do
    it "returns the total number of nights for the reservation" do
      @reservation.nights.must_equal @nights
    end

    it "returns zero if the reservation ends on the begin date" do
      range = DateRange.new(@begin, @begin)
      reservation = Reservation.new(range, @room)

      reservation.nights.must_equal 0
    end
  end

  describe "#cost" do
    ROOM_COST = 200 # Change if HotelManager::ROOM_COST changes

    it "returns the total cost of the reservation" do
      expected_cost = @nights * ROOM_COST

      @reservation.cost.must_equal expected_cost
    end

    it "returns a minimum of one night's cost" do
      range = DateRange.new(@begin, @begin)
      reservation = Reservation.new(range, @room)

      reservation.cost.must_equal ROOM_COST
    end
  end
end

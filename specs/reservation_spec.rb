require_relative 'spec_helper'

describe Reservation do
  before do
    @begin = Date.today
    @nights = 3
    @end = @begin + @nights
    @range = DateRange.new(@begin, @end)
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

    it "raises ArgumentError if a valid room number is not provided" do
      proc{ Reservation.new(@range, nil) }.must_raise ArgumentError
      proc{ Reservation.new(@range, "hello") }.must_raise ArgumentError
      proc{ Reservation.new(@range, -1) }.must_raise ArgumentError
      proc{ Reservation.new(@range, 0) }.must_raise ArgumentError
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

  describe "#overlap?" do
    it "returns true if the given date range overlaps this reservation" do
      overlaps = [
        [@begin    , @end    ], # Overlapping exactly
        [@begin - 1, @end - 1], # Overlapping beginning
        [@begin + 1, @end + 1], # Overlapping end
        [@begin + 1, @end - 1], # Overlapping subset
        [@begin - 1, @end + 1], # Overlapping superset
      ]

      overlaps.each do |(begin_date, end_date)|
        overlapping = DateRange.new(begin_date, end_date)

        @reservation.overlap?(overlapping).must_equal true
      end
    end

    it "returns false if the given date range does not overlap this reservation" do
      no_overlaps = [
        [@begin - 3, @begin - 1], # Non-overlapping earlier
        [@end   + 1, @end   + 3], # Non-overlapping later
        [@end      , @end   + 3], # Non-overlapping starting on end date
      ]

      no_overlaps.each do |(begin_date, end_date)|
        no_overlapping = DateRange.new(begin_date, end_date)

        @reservation.overlap?(no_overlapping).must_equal false
      end
    end

    it "raises ArgumentError if a DateRange is not provided" do
      proc{ @reservation.overlap? nil }.must_raise ArgumentError
      proc{ @reservation.overlap? "hello" }.must_raise ArgumentError
      proc{ @reservation.overlap? 5 }.must_raise ArgumentError
    end
  end
end

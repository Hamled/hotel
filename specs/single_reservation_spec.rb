require_relative 'spec_helper'

describe SingleReservation do
  before do
    @range = DateRange.new(Date.today, Date.today + 3)
    @room = 1
    @reservation = SingleReservation.new(@range, @room)
  end

  describe "#initialize" do
    it "stores a date range" do
      @reservation.date_range.must_equal @range
    end

    it "stores a room number" do
      @reservation.room.must_equal @room
    end

    it "raises ArgumentError if a DateRange is not provided" do
      proc{ SingleReservation.new(nil, @room) }.must_raise ArgumentError
      proc{ SingleReservation.new(5, @room) }.must_raise ArgumentError
    end

    it "raises ArgumentError if a valid room number is not provided" do
      proc{ SingleReservation.new(@range, nil) }.must_raise ArgumentError
      proc{ SingleReservation.new(@range, "hello") }.must_raise ArgumentError
      proc{ SingleReservation.new(@range, -1) }.must_raise ArgumentError
      proc{ SingleReservation.new(@range, 0) }.must_raise ArgumentError
    end
  end

  describe "#rooms" do
    it "returns a collection with the room number" do
      @reservation.rooms.must_be_kind_of Enumerable
      @reservation.rooms.count.must_equal 1
      @reservation.rooms.must_include @room
    end

    it "returns only valid room numbers" do
      @reservation.rooms.each do |room|
        Reservation.valid_room?(room).must_equal true
      end
    end
  end
end

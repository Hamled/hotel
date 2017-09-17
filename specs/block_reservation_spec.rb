require_relative 'spec_helper'

describe BlockReservation do
  before do
    @range = DateRange.new(Date.today, Date.today + 3)
    @rooms = [1, 2, 3]
    @reservation = BlockReservation.new(@range, @rooms)
  end

  describe "#initialize" do
    it "stores a date range" do
      @reservation.date_range.must_equal @range
    end

    it "stores a collection of rooms" do
      @reservation.rooms.must_equal @rooms
    end

    it "raises ArgumentError if a DateRange is not provided" do
      proc{ BlockReservation.new(nil, @room) }.must_raise ArgumentError
      proc{ BlockReservation.new(5, @room) }.must_raise ArgumentError
    end

    it "raises ArgumentError if a collection of room numbers is not provided" do
      proc{ BlockReservation.new(@range, nil) }.must_raise ArgumentError
      proc{ BlockReservation.new(@range, "hello") }.must_raise ArgumentError
      proc{ BlockReservation.new(@range, -1) }.must_raise ArgumentError
      proc{ BlockReservation.new(@range, 0) }.must_raise ArgumentError
    end

    it "raises ArgumentError if given an empty collection of room numbers" do
      proc{ BlockReservation.new(@range, []) }.must_raise ArgumentError
    end

    it "raises ArgumentError if any room number is invalid" do
      @rooms.count.times do |n|
        rooms = @rooms.map.with_index { |r, i| r unless i == n }

        proc{ BlockReservation.new(@range, rooms) }.must_raise ArgumentError
      end
    end
  end

  describe "#rooms" do
    it "returns a collection of room numbers" do
      @reservation.rooms.must_be_kind_of Enumerable
      @reservation.rooms.count.must_equal @rooms.count
    end

    it "returns only valid room numbers" do
      @reservation.rooms.each do |room|
        Reservation.valid_room?(room).must_equal true
      end
    end
  end
end

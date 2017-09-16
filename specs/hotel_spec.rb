require_relative 'spec_helper'

describe Hotel do
  before do
    @hotel = Hotel.new
  end

  describe "#initialize" do
    it "creates a collection of rooms" do
      @hotel.must_respond_to :rooms
    end

    it "starts with 20 rooms" do
      @hotel.rooms.count.must_equal 20
    end

    it "creates a collection of reservations" do
      @hotel.must_respond_to :reservations
    end

    it "starts with no reservations" do
      @hotel.reservations.empty?.must_equal true
    end
  end

  describe "#reserve!" do
    before do
      @range = DateRange.new(Date.today, Date.today + 3)
    end

    it "returns a new Reservation for the given date range" do
      reservation = @hotel.reserve!(@range)

      reservation.must_be_kind_of Reservation
      reservation.date_range.must_equal @range
    end

    it "adds a reservation to the Hotel's reservations collection" do
      reservations_before = @hotel.reservations.count

      reservation = @hotel.reserve!(@range)

      @hotel.reservations.count.must_equal (reservations_before + 1)
      @hotel.reservations.must_include reservation
    end

    it "raises ArgumentError if a DateRange is not provided" do
      proc{ @hotel.reserve!(nil) }.must_raise ArgumentError
      proc{ @hotel.reserve!(5) }.must_raise ArgumentError
    end

    it "raises NoAvailableRoomError if all rooms are reserved for the given date range" do
      20.times { @hotel.reserve!(@range) }

      proc{ @hotel.reserve!(@range) }.must_raise NoAvailableRoomError
    end
  end

  describe "#availability" do
    before do
      @range = DateRange.new(Date.today, Date.today + 3)
    end

    it "returns a collection of rooms that are available for the given date range" do
      # No reservations have been made yet
      @hotel.availability(@range).must_equal @hotel.rooms

      # After making reservations
      20.times do |i|
        @hotel.reserve!(@range)
        @hotel.availability(@range).count.must_equal @hotel.rooms.count - (i + 1)
      end
    end

    it "ignores reservations that do not overlap the given date range" do
      @hotel.availability(@range).must_equal @hotel.rooms

      range_before = DateRange.new(@range.begin - 3, @range.begin - 1)
      20.times do |i|
        @hotel.reserve!(range_before)
        @hotel.availability(@range).must_equal @hotel.rooms
      end

      range_after = DateRange.new(@range.end, @range.end + 3)
      20.times do |i|
        @hotel.reserve!(range_after)
        @hotel.availability(@range).must_equal @hotel.rooms
      end
    end

    # TODO: This should probably be cleaned up
    it "considers reservations that overlap the given date range" do
      @hotel.availability(@range).must_equal @hotel.rooms

      overlap_before = DateRange.new(@range.begin - 1, @range.end - 1)
      @hotel.reserve!(overlap_before)
      @hotel.availability(@range).count.must_equal @hotel.rooms.count - 1

      overlap_after = DateRange.new(@range.begin + 1, @range.end + 1)
      @hotel.reserve!(overlap_after)
      @hotel.availability(@range).count.must_equal @hotel.rooms.count - 2

      overlap_subset = DateRange.new(@range.begin + 1, @range.end - 1)
      @hotel.reserve!(overlap_subset)
      @hotel.availability(@range).count.must_equal @hotel.rooms.count - 3

      overlap_superset = DateRange.new(@range.begin - 1, @range.end + 1)
      @hotel.reserve!(overlap_superset)
      @hotel.availability(@range).count.must_equal @hotel.rooms.count - 4
    end
  end
end

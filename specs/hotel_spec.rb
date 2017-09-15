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
  end
end

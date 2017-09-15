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
  end
end

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
  end
end

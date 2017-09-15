class HotelManager::Reservation
  attr_reader :date_range, :room

  def initialize(date_range, room)
    raise ArgumentError.new("Reservation.new must be called with a DateRange") unless date_range.is_a? DateRange

    @date_range = date_range
    @room = room
  end

  def nights
    date_range.count
  end

  def cost
    [1, nights].max * ROOM_COST
  end
end

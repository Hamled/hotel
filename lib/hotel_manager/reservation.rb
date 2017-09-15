class HotelManager::Reservation
  attr_reader :date_range, :room

  def initialize(date_range, room)
    raise ArgumentError.new("Reservation.new must be called with a DateRange") unless date_range.is_a? DateRange
    unless room.is_a?(Integer) && room.positive?
      raise ArgumentError.new("Reservation.new must be called with a valid room number")
    end

    @date_range = date_range
    @room = room
  end

  def nights
    date_range.count
  end

  # In Rails (or anything with ActiveSupport) this could be simplified to:
  # delegate :overlap?, to: :date_range
  def overlap?(other_range)
    date_range.overlap? other_range
  end

  def cost
    [1, nights].max * ROOM_COST
  end
end

class HotelManager::Reservation
  attr_reader :date_range

  def initialize(date_range)
    raise ArgumentError.new("Reservation.new must be called with a DateRange") unless date_range.is_a? DateRange
    @date_range = date_range
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

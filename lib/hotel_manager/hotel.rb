class HotelManager::Hotel
  attr_reader :reservations

  def initialize
    @reservations = []
  end

  def rooms
    Array(1..20)
  end

  def reserve!(date_range)
    raise ArgumentError.new("A valid DateRange must be provided to reserve a room") unless date_range.is_a? DateRange

    reservation = Reservation.new(date_range)
    @reservations << reservation

    return reservation
  end
end

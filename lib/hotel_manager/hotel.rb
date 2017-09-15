class HotelManager::Hotel
  attr_reader :reservations

  def initialize
    @reservations = []
  end

  def rooms
    Array(1..20)
  end

  def reserve!(date_range)
    reservation = Reservation.new(date_range)

    return reservation
  end
end

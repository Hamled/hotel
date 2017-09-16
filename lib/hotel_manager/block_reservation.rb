class HotelManager::BlockReservation < HotelManager::Reservation
  attr_reader :rooms

  def initialize(date_range, rooms)
    super(date_range)

    @rooms = rooms
  end
end

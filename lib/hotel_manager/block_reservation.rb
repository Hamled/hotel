class HotelManager::BlockReservation < HotelManager::Reservation
  attr_reader :rooms

  def initialize(date_range, rooms)
    super(date_range)

    unless rooms.is_a?(Enumerable)
      raise ArgumentError.new("BlockReservation.new must be called with a collection of room numbers")
    end

    @rooms = rooms
  end
end

class HotelManager::BlockReservation < HotelManager::Reservation
  attr_reader :rooms

  def initialize(date_range, rooms)
    super(date_range)

    unless rooms.is_a?(Enumerable)
      raise ArgumentError.new("BlockReservation.new must be called with a collection of room numbers")
    end

    if rooms.empty?
      raise ArgumentError.new("BlockReservation.new must be given a collection of at least one room number")
    end

    @rooms = rooms
  end
end

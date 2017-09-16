class HotelManager::SingleReservation < HotelManager::Reservation
  attr_reader :room

  def initialize(date_range, room)
    super(date_range)

    unless Reservation::valid_room? room
      raise ArgumentError.new("SingleReservation.new must be called with a valid room number")
    end

    @room = room
  end
end

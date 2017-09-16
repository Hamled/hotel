require 'set'

class HotelManager::Hotel
  attr_reader :reservations

  def initialize
    @reservations = []
  end

  def rooms
    Set.new(1..20)
  end

  def reserve!(date_range)
    raise ArgumentError.new("A valid DateRange must be provided to reserve a room") unless date_range.is_a? DateRange

    room = available_room(date_range)
    raise NoAvailableRoomError.new("There are no rooms available for this date range (#{date_range})") if room.nil?

    reservation = SingleReservation.new(date_range, room)
    @reservations << reservation

    return reservation
  end

  def availability(date_range)
    rooms - Set.new(reservations_for(date_range).map(&:room))
  end

  private

  def available_room(date_range)
    availability(date_range).to_a.sample
  end

  def reservations_for(date_range)
    reservations.select do |res|
      res.overlap? date_range
    end
  end
end

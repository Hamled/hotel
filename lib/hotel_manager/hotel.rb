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

    reservation = Reservation.new(date_range, available_room(date_range))
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

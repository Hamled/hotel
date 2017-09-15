class HotelManager::Reservation
  attr_reader :date_range

  def initialize(date_range)
    raise ArgumentError.new("Reservation.new must be called with a DateRange") unless date_range.is_a? DateRange

    @date_range = date_range
  end
end

class HotelManager::Reservation
  attr_reader :date_range

  def initialize(date_range)
    @date_range = date_range
  end
end

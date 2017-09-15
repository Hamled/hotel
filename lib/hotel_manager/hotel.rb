class HotelManager::Hotel
  attr_reader :reservations

  def initialize
    @reservations = []
  end

  def rooms
    Array(1..20)
  end
end

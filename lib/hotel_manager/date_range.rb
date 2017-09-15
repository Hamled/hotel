require 'date'

class HotelManager::DateRange < Range
  def initialize(begin_date, end_date)
    unless begin_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError.new("DateRange.new must be passed two Date objects")
    end

    super(begin_date, end_date)
  end
end

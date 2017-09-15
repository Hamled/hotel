require 'date'

class HotelManager::DateRange < Range
  def initialize(begin_date, end_date)
    unless begin_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError.new("DateRange.new must be passed two Date objects")
    end

    if end_date < begin_date
      raise ArgumentError.new("End date must be on or after begin date for DateRange")
    end

    super(begin_date, end_date)
  end
end

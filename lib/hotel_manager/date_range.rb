require 'date'

class HotelManager::DateRange < Range
  def initialize(begin_date, end_date)
    unless begin_date.is_a?(Date) && end_date.is_a?(Date)
      raise ArgumentError.new("DateRange.new must be passed two Date objects")
    end

    if end_date < begin_date
      raise ArgumentError.new("End date must be on or after begin date for DateRange")
    end

    exclude_end = true
    super(begin_date, end_date, exclude_end)
  end

  def overlap?(date_range)
    include?(date_range.begin) || date_range.include?(self.begin)
  end
end

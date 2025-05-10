# frozen_string_literal: true

class DatesCalculatorController
  class InvalidDatesError < StandardError; end

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date

    validate_dates
  end

  def validate_dates
    invalid = @start_date > @end_date
    raise InvalidDatesError, 'StartDate must be before EndDate' if invalid
  end

  def calculate_next_possible_entry_date
    stays = [[@start_date, @end_date]]

    days_in_shengen = stays.flat_map do |from, to|
      (from..to).to_a
    end.uniq

    violations = []

    days_in_shengen.each do |day|
      window = (day - 179)..day
      count = days_in_shengen.count { |d| window.cover?(d) }

      if count > 90
        violations << [day, count]
      end
    end

    p violations
    messages = []

    if violations.empty?
      messages << '✅ You\'re within the 90/180 rule!'
    else
      messages << '🚨 You exceeded the limit on:'
      violations.each do |day, count|
        messages << " - #{day}: #{count} days in previous 180"
      end
    end

    messages.join("\n")
  end
end

# # Read ARGV and parse as date ranges
# 2025-01-11:2025-01-30
# 2025-03-01:2025-03-30
# 2025-05-01:2025-05-30

# stays = ARGV.map do |range|
#   from_str, to_str = range.split(':')
#   [Date.parse(from_str), Date.parse(to_str)]
# end

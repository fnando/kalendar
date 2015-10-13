module Kalendar
  class Calendar
    class Week
      attr_reader :days
      attr_reader :events
      attr_reader :calendar_date
      attr_reader :today

      def initialize(calendar_date, today, days, events)
        @calendar_date = calendar_date
        @today = today
        @days = days
        @events = events
      end

      def each_day(&block)
        days
          .map {|day| Day.new(calendar_date, today, day, events_for_day(day)) }
          .each(&block)
      end

      def events_for_day(day)
        events[day.to_s(:db)] || []
      end
    end
  end
end

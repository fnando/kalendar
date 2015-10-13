module Kalendar
  class Calendar
    class Day
      WEEKEND = [0, 6]
      YEAR_MONTH_FORMAT = "%Y-%m".freeze

      attr_reader :calendar_date
      attr_reader :today
      attr_reader :date
      attr_reader :events

      def initialize(calendar_date, today, date, events)
        @calendar_date = calendar_date
        @today = today
        @date = date
        @events = events
      end

      def today?
        date == today
      end

      def weekend?
        WEEKEND.include?(date.cwday)
      end

      def format
        date.strftime("%Y-%m-%d")
      end

      def current_month?
        calendar_date.strftime(YEAR_MONTH_FORMAT) == date.strftime(YEAR_MONTH_FORMAT)
      end

      def has_events?
        events.any?
      end

      def meta
        @meta ||= [].tap {|meta|
          meta << "date"
          meta << "today" if today?
          meta << "not-current-month" unless current_month?
          meta << "weekend" if weekend?
          meta << "has-events" if has_events?
        }
      end
    end
  end
end

module Kalendar
  class Calendar
    # The date that is being rendered.
    attr_reader :date

    # The year that will be rendered.
    attr_accessor :year

    # The month that will be rendered.
    attr_accessor :month

    # The date that will be considered as "today".
    attr_accessor :today

    # The list of events. It must be a collection of object that respond to
    # the attribute you specified on `field` (by default is `created_at`).
    attr_accessor :events

    # The object's property that will return the date.
    attr_accessor :property

    def initialize(options)
      default_options.merge(options).each do |key, value|
        public_send("#{key}=", value)
      end

      @date = Date.new(year, month)
    end

    def first_day_of_calendar
      @first_day_of_calendar ||= begin
        _date = date.beginning_of_month
        prev_days(_date, _date.cwday).last
      end
    end

    def last_day_of_calendar
      @last_day_of_calendar ||= date.end_of_month
    end

    def days
      @days ||= (first_day_of_calendar..last_day_of_calendar).to_a
    end

    def grouped_events
      @grouped_events ||= events.group_by do |event|
        event.public_send(property).to_date.to_s(:db)
      end
    end

    def weeks
      @weeks ||= begin
        weeks = days.in_groups_of(7)
        last_week = weeks.pop

        last_week.each_with_index do |item, index|
          item = last_week[index - 1].next_day unless item
          last_week[index] = item
        end

        weeks << last_week
        weeks
      end
    end

    def week_days
      @week_days ||= next_days(first_day_of_calendar, 7)
    end

    def each_week_day(&block)
      week_days.each(&block)
    end

    def each_week
      weeks.each do |days_of_week|
        yield Week.new(date, today, days_of_week, grouped_events)
      end
    end

    def default_options
      today = Date.today

      {
        year: today.year,
        month: today.month,
        today: today,
        events: [],
        property: :created_at
      }
    end

    def next_days(date, number_of_days)
      number_of_days.times.map {|offset| date + offset.days }
    end

    def prev_days(date, number_of_days)
      number_of_days.times.map {|offset| date - offset.days }
    end
  end
end

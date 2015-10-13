module Kalendar
  module Helper
    DEFAULT_IDENTIFIER = "calendar".freeze

    # Options:
    #
    # - `id`: the calendar HTML id. Optional.
    # - `class`: the calendar HTML class. Optional.
    # - `today`: the date that will be considered the current date. Defaults to `Date.today`. Optional.
    # - `year`: the year that will be rendered. Optional. Defaults to current year.
    # - `month`: the month that will be rendered. Optional. Defaults to current month.
    # - `events`: a collection of events that will be rendered on the calendar.
    # - `property`: the property that will be used for grouping events. Optional. Defaults to `created_at`.
    #
    def calendar(options = {}, &block)
      render "kalendar/kalendar",
        calendar_id: options.delete(:id) { DEFAULT_IDENTIFIER },
        calendar_class: options.delete(:class) { DEFAULT_IDENTIFIER },
        calendar: Calendar.new(options),
        events_callback: block
    end
  end
end

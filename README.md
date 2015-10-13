# Kalendar

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kalendar'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install kalendar
```

## Usage

Use the `calendar` helper.

```erb
<%= calendar year: 2015, month: 10 %>
```

Or, if you want to register some events:

```erb
<%= calendar year: 2015, month: 10 do |day| %>
  <% for event in Schedule.find_by_date(day.date) %>
    <%= link_to event.title, event_path(event) %>
  <% end %>
<% end %>
```

As you can see, this will hit your database up to 31 times (one hit for each 
day) if you don't optimize it. Fortunately, you can use the options `:events`:

```erb
<%= calendar events: Schedule.all do |day| %>
  <% for event in day.events %>
    <%= link_to event.title, event_path(event) %>
  <% end %>
<% end %>
```

By default, each record will use the `created_at` attribute as date grouping. 
You can specify a different attribute with the option `:property`:

```erb
<%= calendar events: Schedule.all, property: :scheduled_at do |day| %>
  <!-- do something -->
<% end %>
```

You can set the HTML's id and class attributes:

```erb
<%= calendar id: 'cal', class: 'cal' %>
```

### Formatting

Use this CSS as your starting point:

```css
.calendar {
  border-collapse: collapse;
  width: 100%;
}

.calendar td,
.calendar th {
  font-family: sans-serif;
  font-size: 14px;
  padding: 20px;
}

.calendar th {
  color: #666;
  text-align: right;
}

.calendar td {
  border: 1px solid #ddd;
  position: relative;
  width: 14.28%;
}

.calendar .not-current-month {
  background: #f5f5f5;
  color: #ccc;
}

.calendar span {
  display: block;
}

.calendar td.events {
  background: #fff;
}

.calendar td.today {
  background: #ffc;
  color: #666;
}

.calendar caption {
  text-align: left;
  font-weight: bold;
  font-family: sans-serif;
  font-size: 36px;
}

.calendar .has-events time {
  position: absolute;
  right: 20px;
  top: 20px;
}

.calendar time {
  display: block;
  text-align: right;
}

.calendar td > ul {
  margin: 0;
  padding: 0;
  padding-left: 10px;
  margin-right: 30px;
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fnando/kalendar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

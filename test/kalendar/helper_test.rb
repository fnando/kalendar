require "test_helper"

class HelperTest < ActionView::TestCase
  include Kalendar::Helper

  test "using default options" do
    html = Nokogiri::HTML(calendar.to_s)

    assert_select html, "table#calendar.calendar"
    assert_select html, "table > caption", I18n.l(Date.today, format: :"kalendar.caption")
    assert_select html, "td.today > time[datetime='#{Date.today.strftime("%Y-%m-%d")}']", "#{Date.today.day}"
  end

  test "set custom class" do
    html = Nokogiri::HTML(calendar(class: "some-class").to_s)
    assert_select html, "table.some-class"
  end

  test "set custom id" do
    html = Nokogiri::HTML(calendar(id: "some-id").to_s)
    assert_select html, "table#some-id"
  end

  test "renders calendar for Oct/2015" do
    html = Nokogiri::HTML(calendar(year: 2015, month: 10).to_s)
    tds = html.css("tbody td")

    assert_select html, "tbody td", count: 35
    assert_select html, "td:nth-of-type(1) > time[datetime='2015-09-28']", "28"
    assert_select html, "td:nth-of-type(2) > time[datetime='2015-09-29']", "29"

    (1..31).each do |i|
      day = "0#{i}"[-2, 2]
      assert_select tds[i + 2].parent, "td > time[datetime='2015-10-#{day}']", "#{i}"
    end

    assert_select html, "td:last-of-type > time[datetime='2015-11-01']", "1"
  end

  test "renders events" do
    events = 2.times.map {|i| OpenStruct.new(created_at: Date.new(2015, 10, 5), index: i) }
    html = render(file: "./test/support/views/_events.html.erb", locals: {year: 2015, month: 10, events: events})
    html = Nokogiri::HTML(html)
    tds = html.css("td")

    assert_select tds[7], "ul.events > li", count: 2
  end
end

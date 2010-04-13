require 'helper'

class TestBusinessHours < Test::Unit::TestCase
  should "move to tomorrow if we add 8 business hours" do
    first = Time.parse("Aug 4 2010, 9:35 am")
    later = 8.business_hours.after(first)
    expected = Time.parse("Aug 5 2010, 9:35 am")
    assert expected == later
  end
  
  should "move to yesterday if we subtract 8 business hours" do
    first = Time.parse("Aug 4 2010, 9:35 am")
    later = 8.business_hours.before(first)
    expected = Time.parse("Aug 3 2010, 9:35 am")
    assert expected == later
  end
  
  should "take into account a weekend when adding an hour" do
    friday_afternoon = Time.parse("April 9th, 4:50 pm")
    monday_morning = 1.business_hour.after(friday_afternoon)
    expected = Time.parse("April 12th 2010, 9:50 am")
    assert expected == monday_morning
  end
  
  should "take into account a weekend when subtracting an hour" do
    monday_morning = Time.parse("April 12th 2010, 9:50 am")
    friday_afternoon = 1.business_hour.before(monday_morning)
    expected = Time.parse("April 9th 2010, 4:50 pm")
    assert expected == friday_afternoon
  end
  
  
  should "take into account a holiday" do
    BusinessTime::Config.holidays << Date.parse("July 5th, 2010")
    friday_afternoon = Time.parse("July 2nd 2010, 4:50pm")
    tuesday_morning = 1.business_hour.after(friday_afternoon)
    expected = Time.parse("July 6th 2010, 9:50 am")
    assert expected == tuesday_morning
  end
  
  should "add hours in the middle of the workday"  do
    monday_morning = Time.parse("April 12th 2010, 9:50 am")
    later = 3.business_hours.after(monday_morning)
    expected = Time.parse("April 12th 2010, 12:50 pm")
    assert expected == later
  end
  
  
end

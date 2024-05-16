require 'date'

def weekday_date
  today = Date.today
  
  if today.on_weekend?
    return today.next_day(2)
  else
    return today
  end
end

def weekend_date
  today = Date.today
  
  if today.on_weekend?
    return today
  else
    return today.next_day(6 - today.wday)
  end
end


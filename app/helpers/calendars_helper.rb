module CalendarsHelper
  def calendar_event_style(event, hour_start, hour_end)
    event_start = event.start_time.in_time_zone
    event_end   = event.end_time.in_time_zone

    block_minutes = (hour_end - hour_start) / 60

    event_start_overlap = [ event_start, hour_start ].max
    event_end_overlap   = [ event_end,   hour_end ].min
    overlap_minutes     = (event_end_overlap - event_start_overlap) / 60

    height_percent = (overlap_minutes / block_minutes) * 100

    offset_minutes = (event_start_overlap - hour_start) / 60
    offset_percent = (offset_minutes / block_minutes) * 100

    "position: absolute; top: #{offset_percent}%; height: #{height_percent}%; left: 5%; right: 5%;"
  end

  def calendar_event_full_day_style(event, day_start)
    total_minutes = 24 * 60.0

    event_start = event.start_time.to_time
    event_end   = event.end_time.to_time

    offset_minutes = ((event_start - day_start) / 60.0).clamp(0, total_minutes)
    duration_minutes = ((event_end - event_start) / 60.0).clamp(0, total_minutes - offset_minutes)

    offset_percent = (offset_minutes / total_minutes) * 100
    height_percent = (duration_minutes / total_minutes) * 100

    "position: absolute; top: #{offset_percent}%; height: #{height_percent}%; left: 5%; right: 5%;"
  end
end

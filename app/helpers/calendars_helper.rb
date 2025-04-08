module CalendarsHelper
  def calendar_event_style(event, hour_start, hour_end)
    event_start = event.start_time.to_time
    event_end   = event.end_time.to_time

    block_minutes = (hour_end - hour_start) / 60

    event_start_overlap = [ event_start, hour_start ].max
    event_end_overlap   = [ event_end,   hour_end ].min
    overlap_minutes     = (event_end_overlap - event_start_overlap) / 60

    height_percent = (overlap_minutes / block_minutes) * 100

    offset_minutes = (event_start_overlap - hour_start) / 60
    offset_percent = (offset_minutes / block_minutes) * 100

    "position: absolute; top: #{offset_percent}%; height: #{height_percent}%; left: 5%; right: 5%;"
  end
end

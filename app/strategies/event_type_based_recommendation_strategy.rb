class EventTypeBasedRecommendationStrategy
  include EventRecommendationStrategy

  def recommend(attendee_user)
    preferred_event_types = attendee_user.events.distinct.pluck(:event_type)

    if preferred_event_types.empty?
      events = Event.order(created_at: :desc)
    else
      events = Event.where(event_type: preferred_event_types).order(created_at: :desc)
    end

    events.reject { |event| attendee_user.registered_for_event?(event.id) }.first(10)
  end
end

class EventTypeBasedRecommendationStrategy
  include EventRecommendationStrategy

  def recommend(attendee_user)
    preferred_event_types = attendee_user.events.distinct.pluck(:event_type)
    
    # if the user has no preferred types, return a list of 10 upcoming events
    return Event.order(created_at: :desc).first(10) if preferred_event_types.empty?

    # else, return events based on user preferred event types, excluding events the user is already registered for
    Event.where(event_type: preferred_event_types)
                 .order(created_at: :desc)
                 .reject { |event| attendee_user.registered_for_event?(event.id) }
                 .first(10)
  end
end

class EventCategoryBasedRecommendationStrategy
  include EventRecommendationStrategy

  def recommend(user)
    # TODO: uncomment this once category is added to event model
    # preferred_categories = user.events.pluck(:category).uniq
    # Event.where(category: preferred_categories).order(created_at: :desc).limit(10)
  end
end

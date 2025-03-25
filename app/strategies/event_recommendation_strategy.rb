module EventRecommendationStrategy
  def recommend(user)
    raise NotImplementedError, "Recommendation strategy must implement the recommend method"
  end
end

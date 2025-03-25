class RecommendedEventsService
  def initialize(user, strategy: nil)
    @user = user
    @strategy = strategy || determine_strategy
  end

  def call
    @strategy.recommend(@user)
  end

  private

  def determine_strategy
    # Default strategy for now since we don't have user preferences yet
    EventTypeBasedRecommendationStrategy.new
  end
end

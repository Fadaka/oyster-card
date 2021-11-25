class JourneyLog
  attr_reader :journeys
  
  def initialize(journey_class: Journey)
    @journeys = []
    @journey_class = journey_class
    @current_journey 
  end

  def start(station)
    @journeys << station
  end
a_journey = { entry: 'station', exit: nil }

  private
  def current_journey
    @current_journey ||= journey_class.new
  end
end


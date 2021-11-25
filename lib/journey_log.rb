class JourneyLog
  attr_reader :journeys

  def initialize
    @journeys = []
  end

  def start(station)
    @journeys << station
  end
end
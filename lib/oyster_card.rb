MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
class Oystercard

  attr_reader :balance, :entry_station, :journeys, :journey, :entry, :exit_station
 
  def initialize
    @balance = 0
    @entry_station = []
    @journeys = []
    @journey = Hash.new
  end

  def top_up(money)
    @balance += money
    if @balance > MAXIMUM_BALANCE
      raise 'Can not exceed more than £90.'
    end
  end

  def touch_in(station)
    @entry_station << station
    @journey[:entry] = station
    if MINIMUM_FARE > @balance
      raise 'insufficient funds'
    end
  end

  def touch_out(station_out)
    @journey[:exit_station] = station_out
    @journeys << @journey
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end  

  def in_journey?
    @entry_station.empty? == false
  end

  private

   def deduct(money)
    @balance -= money
  end

end

# frozen_string_literal: true

MAXIMUM_BALANCE = 90
MINIMUM_FARE = 1
class Oystercard
  attr_reader :balance, :entry_station, :journeys, :journey, :entry, :exit_station

  def initialize
    @balance = 0
    @journeys = []
    @journey = Journey.new
    @entry_station = nil
  end

  def top_up(amount)
    @balance += amount
    raise 'Can not exceed more than £90.' if @balance > MAXIMUM_BALANCE
  end

  def touch_in(station)
    #penalizes no touch out (incomplete) journey 
    if in_journey?
      @journeys << @journey 
      deduct(@journey.fare)
    end
    @entry_station = station
    @journey = Journey.new(station)
    raise 'insufficient funds' if MINIMUM_FARE > @balance
  end

  def touch_out(station_out)
    #penalizes no touch in(incomplete) journey
    if in_journey? == false
      @journeys << @journey 
      deduct(@journey.fare)
    else
      @journey.exit_station = station_out
      @journeys << @journey
      deduct(@journey.fare)
    end
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil 
  end

  private

  def deduct(fare)
    @balance -= fare
  end
end

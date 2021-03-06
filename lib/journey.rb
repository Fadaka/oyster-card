# frozen_string_literal: true

class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_accessor :entry_station, :exit_station, :fare

  def initialize(entry_station = nil, exit_station = nil, fare = PENALTY_FARE)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = fare
  end

  def completed?
    @entry_station && @exit_station
  end

  def fare
    @fare = MINIMUM_FARE if completed?
    @fare
  end
end

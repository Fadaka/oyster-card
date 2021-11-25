# frozen_string_literal: true

require 'journey'
require 'oyster_card'
require 'station'

describe Journey do
  let(:journey) { described_class.new }
  let(:station) { Station.new('Aldgate East', 1) }
  let(:station2) { Station.new('Aldgate West', 5) }
  let(:oyster) { Oystercard.new }

  it 'will start a journey' do
    expect(journey.entry_station).to be(nil)
  end

  it 'will finish a journey' do
    journey.exit_station = station2
    expect(journey.exit_station).to eq(station2)
  end

  it 'will penalise by default' do
    expect(journey.fare).to eq(Journey::PENALTY_FARE)
  end

  it 'deducts the minimum fare on a completed journey 'do
    expect(journey.fare).to eq(Journey::MINIMUM_FARE) if journey.completed? 
  end
end

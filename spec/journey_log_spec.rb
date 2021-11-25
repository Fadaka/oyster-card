require 'journey_log'
require 'station'
require 'oyster_card'
require 'journey'

describe JourneyLog do
  let(:journey_log) { described_class.new }
  let(:station) { double :station }
  
  it 'starts a journey' do
    journey_log.start(station)
    expect(journey_log.journeys.length).to eq(1)
  end
end
require 'journey'
require 'oyster_card'
require 'station'

describe Journey do
    let(:journey) {described_class.new}
    let(:station) { Station.new('Aldgate East', 1) }
    let(:oyster) {Oystercard.new}

it 'will start a journey' do
    expect(journey.entry_station).to be(nil)
end


end
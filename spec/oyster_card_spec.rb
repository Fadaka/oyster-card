# frozen_string_literal: true

require 'oyster_card'

describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:prepaid_oyster) { described_class.new(Oystercard::MAXIMUM_BALANCE) }
  let(:oyster1) { double :oystercard }
  let(:station) { double :station }
  let(:station_out) { double :station }

  it 'will have balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  it 'will add money to the balance ' do
    oystercard.top_up(10)
    expect(oystercard.balance).to eq(10)
  end

  it 'raise an error if balance above maximumm limit' do
    expect do
      oystercard.top_up(Oystercard::MAXIMUM_BALANCE + Oystercard::MINIMUM_FARE)
    end.to raise_error('Can not exceed more than £90.')
  end

  it 'will confirm whether it is default not in journey' do
    expect(oystercard.in_journey?).to be(false)
  end

  it 'records incomplete journey' do
    prepaid_oyster.touch_in(station)
    prepaid_oyster.touch_in(station)
    expect(prepaid_oyster.journeys.length).to be(1)
  end

  it 'will confirm if oyster has been touched in' do
    prepaid_oyster.touch_in(station)
    expect(prepaid_oyster.in_journey?).to be(true)
  end

  it 'will confirm if oyster has been touched out' do
    prepaid_oyster.touch_in(station)
    prepaid_oyster.touch_out(station_out)
    expect(prepaid_oyster.entry_station).to be(nil)
  end

  it 'will not allow journey with insufficient funds' do
    expect { oystercard.touch_in(station) }.to raise_error(RuntimeError, 'insufficient funds')
  end

  it 'will confirm that oyster has been charged' do
    expect { prepaid_oyster.touch_out(station_out) }.to change { prepaid_oyster.balance }.by(-6)
  end

  it 'will remember the entry station after the touch in' do
    prepaid_oyster.touch_in(station)
    expect(prepaid_oyster.entry_station).to eq(station)
  end

  it 'checks journeys have been saved' do
    prepaid_oyster.touch_in(station)
    prepaid_oyster.touch_out(station_out)
    expect(prepaid_oyster.journeys).to match_array([prepaid_oyster.journey])
  end

  it 'stores a complete journey' do
    prepaid_oyster.touch_in(station)
    prepaid_oyster.touch_out(station_out)
    expect(prepaid_oyster.journeys.last).to eq(prepaid_oyster.journey)
  end

  it 'has no stored journeys by default' do
    expect(oystercard.journeys).to match_array([])
  end
end

require 'rspec'
require_relative 'spec_helper'

describe GameBot::Game::Replay do
  it 'should return a properly formatted string of the replay, and store the number of recorded items.' do
    replay = GameBot::Game::Replay.new

    replay.track('Action 1')
    replay.track('Action 2')
    replay.track('Action 3')

    expect(replay.to_s(:STORE_CSV)).to match(/^[\d\-+: ]+,[A-Z_]+,.+/)
    expect(replay.count).to eq(3)
  end
end

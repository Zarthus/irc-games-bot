require 'rspec'
require_relative 'spec_helper'

describe GameBot do
  it 'should match a valid version' do
    expect(GameBot::VERSION).to match(/\d+\.\d+(\.\d+)?(\-[a-zA-Z])?/)
  end
end

require 'rspec'
require_relative 'spec_helper'

describe Paste do
  it 'should identify Github Gist as a proper service.' do
    expect(Paste.default(:gist)).to eq(:gist)
  end
end

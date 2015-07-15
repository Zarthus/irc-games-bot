require 'rspec'
require_relative 'spec_helper'

describe 'String Helper Functions' do
  it 'should camelize input' do
    expect('mechanism_manager'.camelize).to eq('MechanismManager')
  end

  it 'should underscore input' do
    expect('MechanismManager'.underscore).to eq('mechanism_manager')
  end

end
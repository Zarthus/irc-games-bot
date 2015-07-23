require 'rspec'
require_relative 'spec_helper'

describe GameBot::Game::Info do
  gamelist = GameBot::Game::Info.list
  path = File.join('lib', 'gamebot', 'game', 'games')
  files = Dir.glob(File.join(path, '*.rb'))

  it 'should return a Hash type class' do
    expect(gamelist.class).to eq(Hash)
  end

  it 'should be equal to the number of files in the games directory' do
    expect(gamelist.count).to eq(files.count)
  end

  it 'should not be empty' do
    expect(gamelist.count).not_to eq(0)
  end
end

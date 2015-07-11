require 'rspec'
require 'yaml'

describe 'Example Configuration' do
  file = 'conf/config.example.yaml'

  it 'should exist' do
    expect(File.exists?(file)).to eq(true)
  end

  it 'should be readable' do
    expect(File.readable?(file)).to eq(true)
  end

  it 'should be a valid YAML file' do
    expect(YAML.load_file(file).instance_of?(Hash)).to eq(true)
  end
end
# encoding: utf-8
require './lib/buildbox'
require './spec/spec_helper'

describe BuildBox do

  it 'reads default account and api key settings from environment' do
    pending 'setting up keys'
    bb = BuildBox.new
    response = bb.check_connection
    puts response
  end

  it 'fetches branch build data' do
  end

end
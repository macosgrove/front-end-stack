# encoding: utf-8
require './lib/buildbox'
require './spec/spec_helper'

describe BuildBox do

  it 'can connect to buildbox using default account and api key settings from environment' do
    bb = BuildBox.new
    response = bb.check_connection
    expect(response.code).to be 200
    expect(response.body).to include('email')
  end

  it 'fetches branch build data' do
    bb = BuildBox.new
    response = bb.fetch_branch_builds('marketplace', 'master')
    expect(response.code).to be 200
    expect(response.body).to include('"branch": "master"')
  end

end
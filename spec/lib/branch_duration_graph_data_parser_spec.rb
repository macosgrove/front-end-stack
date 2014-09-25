# encoding: utf-8
require './spec/spec_helper'

describe BranchDurationGraphDataParser do

  let(:test_data) { '[{}]'}
  let(:buildbox) { double(BuildBox, :fetch_branch_builds => double(:body => test_data)) }
  subject(:parser) { described_class.new(buildbox) }

  before do
    parser.fetch_and_parse('any project', 'any branch')
  end

  context 'with a single build and job' do
    let(:test_data) { '[{"number": 197, "jobs": [
        {"name": "Jasmine",
        "state": "passed",
        "scheduled_at": "2014-09-22 04:29:45 UTC",
        "started_at": "2014-09-22 04:29:47 UTC",
        "finished_at": "2014-09-22 04:37:07 UTC"}]}]'}

    let(:job) { parser.steps["Jasmine"].first }

    it 'sets the build number' do
      expect(job.build).to  be 197
    end

    it 'sets the state' do
      expect(job.state).to eq "passed"
    end

    it 'sets duration in seconds' do
      expect(job.duration).to be 440
    end

    it 'emits json suited to the graph' do
      expect(parser.branch_duration_graph_data).to eq '[[{"x":197,"y":440,"step":"Jasmine","state":"passed"}]]'
    end
  end

  context 'with waiter jobs' do
    let(:test_data) {'[{"number": 197, "jobs": [
            {"type": "waiter"}]}]'
    }

    it 'ignores the waiter jobs' do
      expect(parser.steps).to be_empty
    end

  end

  context 'with two steps' do
    let(:test_data) { '[{"number": 34, "jobs": [
        {"name": "Jasmine", "state": "passed"}, {"name": "RSpec", "state": "failed"}]}]'}

    it 'organises the jobs into steps' do
      expect(parser.steps.keys).to eq %w(Jasmine RSpec)
    end

    it 'creates jobs' do
      expect(parser.steps.keys).to eq %w(Jasmine RSpec)
      expect(parser.steps["RSpec"].count).to  be 1
    end

  end

  context 'with realistic data' do
    let(:test_data) { File.open('./spec/fixtures/branch_data.json').read }

    it 'produces the expected output' do
      expected_output = File.open('./spec/fixtures/expected_output.json').read
      expect(parser.branch_duration_graph_data).to eq(expected_output)
    end
  end


end

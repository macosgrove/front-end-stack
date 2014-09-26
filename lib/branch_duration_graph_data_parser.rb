require 'json'

class BranchDurationGraphDataParser

  attr_reader :steps

  def initialize(buildbox)
    @buildbox = buildbox
    @steps = {}
  end

  def fetch_and_parse(project, branch, per_page=15, page=1)
    parse(@buildbox.fetch_branch_builds(project, branch, per_page=15, page=1).body)
  end

  def parse(data)
    builds = JSON.parse(data)
    builds.each do |build|
      build["jobs"].each do |job|
        unless job["type"] == "waiter"
          @steps[job["name"]] ||= []
          @steps[job["name"]] << BuildJob.new(build["number"], job)
        end
      end
    end
  end

  def to_json
    @steps.values.to_json
  end

  alias_method :branch_duration_graph_data, :to_json

end


require 'json'

class BuildJob

  attr_reader :build, :state, :duration

  def initialize(build, input_json)
    @build = build
    @state = input_json["state"]
    @duration = seconds_between(input_json["started_at"], input_json["finished_at"])
  end

  def seconds_between(start_s, finish_s)
    return nil unless start_s && finish_s
    finish = DateTime.parse(finish_s).to_time
    start = DateTime.parse(start_s).to_time
    time = finish - start
    time.to_i.to_s
  end

  def to_json(options = {})
    {
      "build" => @build.to_s,
      "duration" => @duration.to_s,
      "state" => @state
    }.to_json(options)
  end

end
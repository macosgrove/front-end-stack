require 'json'

class BuildJob

  attr_reader :step, :build, :state, :duration

  def initialize(build, input_json)
    @build = build
    @state = input_json["state"]
    @step = input_json["name"]
    @duration = seconds_between(input_json["started_at"], input_json["finished_at"])
  end

  def seconds_between(start_s, finish_s)
    return 0 unless start_s && finish_s
    finish = DateTime.parse(finish_s).to_time
    start = DateTime.parse(start_s).to_time
    time = finish - start
    time.to_i
  end

  def to_json(options = {})
    {
      "x" => @build,
      "y" => @duration,
      "step" => @step,
      "state" => @state
    }.to_json(options)
  end

end
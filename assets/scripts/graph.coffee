
class Graph
  constructor: ->
    @$chart = $('#chart')

    @project = @$chart.data('project')
    @branch = @$chart.data('branch')

    @graphify()

  graphify: ->
    @graph = new Rickshaw.Graph.Ajax
      element:    @$chart.get(0)
      width:      580
      height:     250
      renderer:   'bar'
      # stack:      false
      dataURL:    "/data/#{@project}/#{@branch}"
      onData:     (data) => return @transform(data)
      onComplete: (w) => @complete(w)

  complete: (w) ->
    @legend = new Rickshaw.Graph.Legend
      element: document.querySelector('#legend')
      graph:   w.graph

    # @xAxis = new Rickshaw.Graph.Axis.Time(graph: w.graph)
    # @xAxis = new Rickshaw.Graph.Axis.X
    #   graph:        w.graph

    @yAxis = new Rickshaw.Graph.Axis.Y
        graph: w.graph

    # @xAxis.render()
    @yAxis.render()

    @hoverDetail = new Rickshaw.Graph.HoverDetail
        graph:      w.graph
        xFormatter: (x) -> "Build#{x}"
        yFormatter: (y) -> "#{y} secs"

    opts = {graph:w.graph, legend: @legend}

    shelving = new Rickshaw.Graph.Behavior.Series.Toggle(opts)
    # order = new Rickshaw.Graph.Behavior.Series.Order(opts)
    highlight = new Rickshaw.Graph.Behavior.Series.Highlight(opts)

  transform: (data) ->
    palette = new Rickshaw.Color.Palette(scheme: 'munin');
    data = @data()
    _.map data, (series) ->
      {
        name: series.name
        data: _.map series.data, (s) ->
          {x: parseInt(s.build), y: parseInt(s.duration)}
        color: palette.color()
      }


  data: ->
    [
        {
            "name" : "RSpec",
            "data" : [ { "build" : "1", "duration" : "36", "state" : "passed" }, { "build" : "2", "duration" : "28", "state" : "passed"}]
        },
        {
            "name" : "Cucumber",
            "data" : [ { "build" : "1", "duration" : "410", "state" : "failed" }, { "build" : "2", "duration" : "453", "state" : "running" }]
        },
        {
            "name" : "Jasmine",
            "data" : [ { "build" : "1", "duration" : "5", "state" : "passed" }, { "build" : "2", "duration" : "7", "state" : "passed" }]
        }
    ]


$ ->
  new Graph()


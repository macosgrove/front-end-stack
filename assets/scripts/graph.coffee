
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
      dataURL:    "/data/#{@project}/#{@branch}"
      onData:     (data) => return @transform(data)
      onComplete: (w) => @complete(w)

  complete: (w) ->
    @legend = new Rickshaw.Graph.Legend
      element: document.querySelector('#legend')
      graph:   w.graph

    # @xAxis = new Rickshaw.Graph.Axis.Time(graph: w.graph)
    @xAxis = new Rickshaw.Graph.Axis.X
      graph:        w.graph
      tickFormat:   Rickshaw.Fixtures.Number.formatKMBT
      element:      document.querySelector('#y-axis')


    @yAxis = new Rickshaw.Graph.Axis.Y
        graph:        w.graph
        orientation:  'left'
        tickFormat:   Rickshaw.Fixtures.Number.formatKMBT
        element:      document.querySelector('#y-axis')

    opts = {graph:w.graph, legend: @legend}

    shelving = new Rickshaw.Graph.Behavior.Series.Toggle(opts)
    # order = new Rickshaw.Graph.Behavior.Series.Order(opts)
    highlight = new Rickshaw.Graph.Behavior.Series.Highlight(opts)

  transform: (data) ->
    palette = new Rickshaw.Color.Palette(scheme: 'munin');
    return [
        {
          name: "Rspec",
          data: [ { x: 12323, y: 10 }, { x: 228037, y: 11 }],
          color: palette.color()
        },
        {
          name: "Cucumber",
          data: [ { x: 12323, y: 28 }, { x: 228037, y: 2 }],
          color: palette.color()
        },
        {
          name: "Jasmine",
          data: [ { x: 12323, y: 2 }, { x: 228037, y: 1 }],
          color: palette.color()
        },
      ]

$ ->
  new Graph()
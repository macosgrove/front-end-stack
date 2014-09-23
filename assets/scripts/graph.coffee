
class Graph
  constructor: ->
    @$chart = $('#chart')
    @$yAxis = $('#y-axis')

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
      element: document.querySelector('#legend'),
      graph: w.graph

    # @xAxis = new Rickshaw.Graph.Axis.Time(graph: @graph)

    # @yAxis = new Rickshaw.Graph.Axis.Y
    #     graph:        @graph
    #     orientation:  'left'
    #     tickFormat:   Rickshaw.Fixtures.Number.formatKMBT
    #     element:      @$yAxis.get(0)

  transform: (data) ->
    palette = new Rickshaw.Color.Palette(scheme: 'munin');
    return [
        {
          name: "Rspec",
          data: [ { x: 1, y: 10 }, { x: 2, y: 11 }],
          color: palette.color()
        },
        {
          name: "Cucumber",
          data: [ { x: 1, y: 28 }, { x: 2, y: 2 }],
          color: palette.color()
        },
        {
          name: "Jasmine",
          data: [ { x: 1, y: 2 }, { x: 2, y: 1 }],
          color: palette.color()
        },
      ]

$ ->
  new Graph()
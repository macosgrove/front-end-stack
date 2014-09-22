
class Graph
  constructor: ->
    @$chart = $('#chart')

    project = @$chart.data('project')
    branch = @$chart.data('branch')

    $.getJSON "/data/#{project}/#{branch}", (data)=>
      @graphify(data)

  graphify: (data)->
    @graph = new Rickshaw.Graph
      element: @$chart.get(0),
      width: 580,
      height: 250,
      series: [color: 'steelblue', data: data]

    @graph.render()

$ ->
  new Graph()
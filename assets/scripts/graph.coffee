
class Graph
  constructor: (data) ->
    console.log data

    @graph = new Rickshaw.Graph
      element: document.querySelector('#chart'),
      width: 580,
      height: 250,
      series: [color: 'steelblue', data: data]

  render: ->
    @graph.render()

$ ->
  data = eval($('#data').text().trim())
  g = new Graph(data)
  g.render()
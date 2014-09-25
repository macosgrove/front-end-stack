class GraphD3
  change = ->
    clearTimeout timeout
    # if @value is "grouped"
      # transitionGrouped()
    # else
    transitionStacked()
    return

  transitionStacked = ->
    y.domain [
      0
      yStackMax
    ]
    rect.transition().duration(500).delay((d, i) ->
      i * 10
    ).attr("y", (d) ->
      y d.y0 + d.y
    ).attr("height", (d) ->
      y(d.y0) - y(d.y0 + d.y)
    ).transition().attr("x", (d) ->
      x d.x
    ).attr "width", x.rangeBand()
    return

  data =
  [
    {
      "name": "RSpec",
      "values": [ { "x": 1, "y": 36, "state": "passed" }, { "x": 2, "y": 28, "state": "passed"}]
    },
    {
      "name": "Cucumber",
      "values": [ { "x": 1, "y": 410, "state": "failed" }, { "x": 2, "y": 453, "state": "running" }]
    },
    {
      "name": "Jasmine",
      "values": [ { "x": 1, "y": 5, "state": "passed" }, { "x": 2, "y": 7, "state": "passed" }]
    }
  ]

  data2 =
  [
      [ { "x": 1, "y": 36, "job": "rspec", "state": "passed" }, { "x": 2, "y": 28, "job": "cucumber", "state": "passed"}]
      [ { "x": 1, "y": 410, "job": "rspec", "state": "failed" }, { "x": 2, "y": 453, "job": "cucumber", "state": "running" }]
      [ { "x": 1, "y": 5, "job": "rspec", "state": "passed" }, { "x": 2, "y": 7, "job": "cucumber", "state": "passed" }]
  ]


  # number of layers
  n = 3
  # number of samples per layer
  m = 2

  stack = d3.layout.stack()
  layers = stack(data2)

  yGroupMax = d3.max(layers, (layer) ->
    d3.max layer, (d) ->
      d.y
  )

  yStackMax = d3.max(layers, (layer) ->
    d3.max layer, (d) ->
      d.y0 + d.y
  )

  margin =
    top: 40
    right: 10
    bottom: 20
    left: 10

  width = 960 - margin.left - margin.right
  height = 500 - margin.top - margin.bottom

  x = d3.scale.ordinal()
    .domain(d3.range(m))
    .rangeRoundBands([ 0, width ], 0.1)

  y = d3.scale.linear()
    .domain([ 0, yStackMax ])
    .range([ height, 0 ])

  xAxis =
    d3.svg.axis()
      .scale(x)
      .tickSize(0)
      .tickPadding(6)
      .orient("bottom")

  yAxis =
    d3.svg.axis()
      .scale(y)
      .tickSize(0)
      .tickPadding(6)
      .orient("left")

  svg = d3.select("body")
    .append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform","translate(" + margin.left + "," + margin.top + ")")

  layer = svg.selectAll(".layer")
    .data(layers)
    .enter()
      .append("g")
        .attr("class", "layer")

  color =
    rspec:
      passed: "#0f0"
      running: "#ff0"
      failed: "#f00"

    cucumber:
      passed: "#0f0"
      running: "#ff0"
      failed: "#f00"


  rect = layer.selectAll("rect")
    .data((d) -> d)
    .enter()
      .append("rect")
        .attr("x", (d) -> x d.x)
        .attr("y", height)
        .attr("width", x.rangeBand())
        .attr("height", 0)
        .style("fill", (d, i) ->
          color[d.job][d.state] or "#999999"
        )

  rect.transition()
    .delay((d, i) -> i * 10)
    .attr("y", (d) -> y d.y0 + d.y  )
    .attr "height", (d) -> y(d.y0) - y(d.y0 + d.y)

  svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call xAxis
  svg.append("g").attr("class", "y axis").attr("transform", "translate(2, 0)").call yAxis


$ ->
  new GraphD3()

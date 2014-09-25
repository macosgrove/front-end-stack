class GraphD3

  data =
  [
      [ { "x": 1, "y": 36, "step": "RSpec", "state": "passed" }, { "x": 2, "y": 28, "step": "RSpec", "state": "passed"}]
      [ { "x": 1, "y": 410, "step": "Cucumber", "state": "failed" }, { "x": 2, "y": 453, "step": "Cucumber", "state": "running" }]
      [ { "x": 1, "y": 5, "step": "Jasmine", "state": "passed" }, { "x": 2, "y": 7, "step": "Jasmine", "state": "passed" }]
  ]


  stack = d3.layout.stack()
  layers = stack(data)

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

  xScale = d3.scale.ordinal()
    .domain(d3.range(data[0].length))
    .rangeRoundBands([ 0, width ], 0.1)

  yScale = d3.scale.linear()
    .domain([ 0, yStackMax ])
    .range([ height, 0 ])

  xAxis =
    d3.svg.axis()
      .scale(xScale)
      .tickSize(0)
      .tickPadding(6)
      .orient("bottom")

  yAxis =
    d3.svg.axis()
      .scale(yScale)
      .tickSize(5)
      .tickPadding(0)
      .orient("left")

  svg = d3.select(".graph")
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
    RSpec:
      passed: "#0f0"
      running: "#ff0"
      failed: "#f00"

    Cucumber:
      passed: "#080"
      running: "#880"
      failed: "#800"

    Jasmine:
      passed: "#8f8"
      running: "#ff8"
      failed: "#f88"


  rect = layer.selectAll("rect")
    .data((d) -> d)
    .enter()
      .append("rect")
        .attr("x", (d) -> xScale d.x)
        .attr("y", height)
        .attr("width", xScale.rangeBand())
        .attr("height", 0)
        .style("fill", (d, i) ->
          color[d.step][d.state] or "#999999"
        )

  rect.transition()
    .delay((d, i) -> i * 10)
    .attr("y", (d) -> yScale d.y0 + d.y  )
    .attr "height", (d) -> yScale(d.y0) - yScale(d.y0 + d.y)

  svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call xAxis
  svg.append("g").attr("class", "y axis").attr("transform", "translate(2, 0)").call yAxis


$ ->
  new GraphD3()

window.Graphbox ?= {}
window.Graphbox.Graph ?= {}

class Graphbox.Graph.Base

  constructor: (@data) ->

    data =
      [[{"x":7739,"y":47,"step":"Jasmine","state":"passed"},{"x":7736,"y":46,"step":"Jasmine","state":"passed"},{"x":7733,"y":45,"step":"Jasmine","state":"passed"},{"x":7708,"y":44,"step":"Jasmine","state":"passed"},{"x":7700,"y":47,"step":"Jasmine","state":"passed"}],[{"x":7739,"y":429,"step":"Cucumber","state":"passed"},{"x":7736,"y":430,"step":"Cucumber","state":"passed"},{"x":7733,"y":430,"step":"Cucumber","state":"failed"},{"x":7708,"y":421,"step":"Cucumber","state":"passed"},{"x":7700,"y":416,"step":"Cucumber","state":"passed"}],[{"x":7739,"y":228,"step":"RSpec","state":"passed"},{"x":7736,"y":226,"step":"RSpec","state":"passed"},{"x":7733,"y":229,"step":"RSpec","state":"passed"},{"x":7708,"y":227,"step":"RSpec","state":"passed"},{"x":7700,"y":224,"step":"RSpec","state":"passed"}],[{"x":7739,"y":4,"step":"Tag Green","state":"passed"},{"x":7736,"y":3,"step":"Tag Green","state":"passed"},{"x":7733,"y":0,"step":"Tag Green","state":"waiting_failed"},{"x":7708,"y":3,"step":"Tag Green","state":"passed"},{"x":7700,"y":4,"step":"Tag Green","state":"passed"}]]

    @data ||= data

  attach: (@target) ->

    stack = d3.layout.stack()
    layers = stack(@data)

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
    .domain(d3.range(@data[0].length))
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

    svg = d3.select(@target)
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
      "RSpec":
        passed: "#0f0"
        running: "#ff0"
        failed: "#f00"
      "Cucumber":
        passed: "#080"
        running: "#880"
        failed: "#800"
      "Jasmine":
        passed: "#8f8"
        running: "#ff8"
        failed: "#f88"
      "Tag Green":
        passed: "#8f8"
        running: "#ff8"
        failed: "#f88"

    rect = layer.selectAll("rect")
    .data((d) -> d)
    .enter()
    .append("rect")
    .attr("x", (d, i) -> xScale i)
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
class GraphD3
  change = ->
    clearTimeout timeout
    if @value is "grouped"
      transitionGrouped()
    else
      transitionStacked()
    return

  transitionGrouped = ->
    y.domain [
      0
      yGroupMax
    ]
    rect.transition().duration(500).delay((d, i) ->
      i * 10
    ).attr("x", (d, i, j) ->
      x(d.x) + x.rangeBand() / n * j
    ).attr("width", x.rangeBand() / n).transition().attr("y", (d) ->
      y d.y
    ).attr "height", (d) ->
      height - y(d.y)

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

  # Inspired by Lee Byron's test data generator.
  bumpLayer = (n, o) ->
    bump = (a) ->
      x = 1 / (.1 + Math.random())
      y = 2 * Math.random() - .5
      z = 10 / (.1 + Math.random())
      i = 0

      while i < n
        w = (i / n - y) * z
        a[i] += x * Math.exp(-w * w)
        i++
      return
    a = []
    i = undefined
    i = 0
    while i < n
      a[i] = o + o * Math.random()
      ++i
    i = 0
    while i < 5
      bump a
      ++i
    a.map (d, i) ->
      x: i
      y: Math.max(0, d)

  # number of layers
  n = 4
  # number of samples per layer
  m = 58

  stack = d3.layout.stack()
  layers = stack(d3.range(n).map(->
    bumpLayer m, .1
  ))

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
    .rangeRoundBands([ 0, width ], .08)

  y = d3.scale.linear()
    .domain([ 0, yStackMax ])
    .range([ height, 0 ])

  color = d3.scale.linear().domain([0, n - 1]).range(["#a0d", "#556" ])

  xAxis =
    d3.svg.axis()
      .scale(x)
      .tickSize(0)
      .tickPadding(6)
      .orient("bottom")

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
      .style("fill", (d, i) ->
        color i
      )

  rect = layer.selectAll("rect").data((d) ->
    d)
      .enter()
      .append("rect")
      .attr("x", (d) ->
        x d.x)
          .attr("y", height)
          .attr("width", x.rangeBand())
          .attr("height", 0)
          .attr("class", "rect-class")

  rect.transition()
    .delay((d, i) ->
      i * 10)
    .attr("y", (d) ->
      y d.y0 + d.y  )
    .attr "height", (d) ->
      y(d.y0) - y(d.y0 + d.y)

  svg.append("g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call xAxis

  d3.selectAll("input").on "change", change

  timeout = setTimeout(->
    d3.select("input[value=\"grouped\"]").property("checked", true).each change
    return
  , 2000)

$ ->
  new GraphD3()

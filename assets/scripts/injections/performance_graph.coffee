window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.PerformanceGraph extends Graphbox.Injection.Base

  constructor: ->
    
    @target = "#graphbox-js_performance_graph_pane"
    @path = "https://graphbox.herokuapp.com/data/marketplace/master?callback=?"

  inject: ->
  	$.getJSON @path, (data) ->
        (new Graphbox.Graph.Base data).attach(@target)
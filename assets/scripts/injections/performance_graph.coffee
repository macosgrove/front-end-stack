window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.PerformanceGraph extends Graphbox.Injection.Base

  constructor: ->
    #imagine I fetch data, or built a path for an ajax graph

    @target = "#graphbox-js_performance_graph_pane"

  inject: ->
  	(new Graphbox.Graph.Base).attach(@target)
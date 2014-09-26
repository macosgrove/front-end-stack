window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.PerformanceGraph extends Graphbox.Injection.Base

  constructor: (@branch, @target)->

    @path = "https://graphbox.herokuapp.com/data/marketplace/#{branch}?callback=?"

  inject: ->
    target = @target
    $.getJSON @path, (data) ->
      (new Graphbox.Graph.Base data).attach(target)
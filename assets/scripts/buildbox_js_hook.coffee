window.Graphbox ?= {}

class Graphbox.Initializer
  
  init: ->

    $.getScript "https://cdnjs.cloudflare.com/ajax/libs/d3/3.4.11/d3.js"
    $ ->
      (new Graphbox.Injection.MenuNavigation).inject()
      (new Graphbox.Injection.ContentPane('graphbox-js_test_graph_pane')).inject()
      (new Graphbox.Injection.ContentPane('graphbox-js_performance_graph_pane')).inject()
      $('#builds-list').addClass('graphbox-js_shown')
      $('ul.pagination').addClass('graphbox-js_shown')
      (new Graphbox.Injection.PerformanceGraph).inject()

(new Graphbox.Initializer).init()
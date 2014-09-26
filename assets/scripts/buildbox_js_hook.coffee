window.Graphbox ?= {}

class Graphbox.Initializer
  
  init: ->

    $.getScript "https://cdnjs.cloudflare.com/ajax/libs/d3/3.4.11/d3.js", this.load_graphs
    $ ->
      (new Graphbox.Injection.MenuNavigation).inject()
      (new Graphbox.Injection.ContentPane('graphbox-js_test_graph_pane')).inject()
      (new Graphbox.Injection.ContentPane('graphbox-js_performance_graph_pane')).inject()
      $('#builds-list').addClass('graphbox-js_shown')
      $('ul.pagination').addClass('graphbox-js_shown')

  load_graphs: ->
    if window.d3 isnt undefined
      $inject_script = $("script[src='https://graphbox.herokuapp.com/js/inject/js']")
      current_branch = $inject_script.data('branch')
      (new Graphbox.Injection.PerformanceGraph current_branch, "#graphbox-js_performance_graph_pane").inject()

      #hack, for testing
      (new Graphbox.Injection.PerformanceGraph "6468-sitemap-fix-we-should-link-to-the-homepage-via-the-sitemaps", "#graphbox-js_test_graph_pane").inject()
    else
      window.setTimeout this.load_graphs, 500

(new Graphbox.Initializer).init()
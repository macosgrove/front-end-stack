window.Graphbox ?= {}

$ -> 
  (new Graphbox.Injection.MenuNavigation).inject()
  (new Graphbox.Injection.ContentPane('graphbox-js_test_graph_pane')).inject()
  (new Graphbox.Injection.ContentPane('graphbox-js_performance_graph_pane')).inject()
  $('#builds-list').addClass('graphbox-js_shown')
  $('ul.pagination').addClass('graphbox-js_shown').show()
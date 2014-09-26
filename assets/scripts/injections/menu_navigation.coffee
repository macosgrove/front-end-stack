window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.MenuNavigation extends Graphbox.Injection.Base

  constructor: ->
    $nav = $("<ul class='hero-navigation' style='margin-top: -8px;'/>")

    $build_btn = $("<li><a class='btn btn-new-default btn-sm'>Build Lists</a></li>")
    $performance_btn = $("<li><a class='btn btn-new-default btn-sm'>Performance Time-Series</a></li>")
    $test_btn = $("<li><a class='btn btn-new-default btn-sm'>Test Time-Series</a></li>")

    $build_btn.on 'click', ->
      $('.graphbox-js_shown').removeClass('graphbox-js_shown').hide()
      $('#builds-list').addClass('graphbox-js_shown').show()
      $('ul.pagination').addClass('graphbox-js_shown').show()

    $performance_btn.on 'click', ->
      $('.graphbox-js_shown').removeClass('graphbox-js_shown').hide()
      $('#graphbox-js_performance_graph_pane').addClass('graphbox-js_shown').show()

    $test_btn.on 'click', ->
      $('.graphbox-js_shown').removeClass('graphbox-js_shown').hide()
      $('#graphbox-js_test_graph_pane').addClass('graphbox-js_shown').show()

    $nav.append($build_btn).append($performance_btn).append($test_btn)

    @content = $nav
    @method = 'append'
    @patient = $('h2.builds-branch-query')
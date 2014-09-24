window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.MenuNavigation extends Graphbox.Injection.Base

  constructor: ->
    $nav = $("<ul class='hero-navigation' style='margin-top: -8px;'/>")

    $build_btn = $("<li><a class='btn btn-new-default btn-sm'>Build Lists</a></li>")
    $performance_btn = $("<li><a class='btn btn-new-default btn-sm'>Performance Time-Series</a></li>")
    $test_btn = $("<li><a class='btn btn-new-default btn-sm'>Test Time-Series</a></li>")

    $build_btn.on 'click', ->
      alert 'build list bro!'

    $performance_btn.on 'click', ->
      alert 'performance graph bro!'

    $test_btn.on 'click', ->
      alert 'test graph bro!'

    $nav.append($build_btn).append($performance_btn).append($test_btn)

    @serum = $nav
    @method = 'append'
    @patient = $('h2.builds-branch-query')
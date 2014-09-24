window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.MenuNavigation

  inject: ->
    $nav = $("<ul class='hero-navigation' style='margin-top: -8px;'/>")

    $nav.append("<li><a class='btn btn-new-default btn-sm'>Performance Time-Series</a></li>")

    $nav.append("<li><a class='btn btn-new-default btn-sm'>Test Time-Series</a></li>")

    $target = $('h2.builds-branch-query')

    new Graphbox.Injector($nav,$target).inject()
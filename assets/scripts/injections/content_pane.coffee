window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.ContentPane extends Graphbox.Injection.Base

  constructor: (@pane_id) ->

    $pane = $("<div id=" + @pane_id + " ></div>")
    $pane.hide()

    $title = $("<h3>" + @pane_id + "</h3>")
    $pane.append($title)

    @content = $pane
    @method = 'after'
    @patient = $('h2.builds-branch-query')
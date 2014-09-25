window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.Base

  constructor: (@content, @patient, @method) ->

  inject: =>
    new Graphbox.Injector(@content,@patient, @method).inject()
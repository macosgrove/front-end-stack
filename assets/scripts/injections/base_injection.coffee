window.Graphbox ?= {}
window.Graphbox.Injection ?= {}

class Graphbox.Injection.Base

  constructor: (@serum, @patient, @method) ->

  inject: =>
    new Graphbox.Injector(@serum,@patient, @method).inject()
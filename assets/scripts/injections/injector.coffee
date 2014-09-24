window.Graphbox ?= {}

class Graphbox.Injector
  constructor: (@payload, @patient, @method) ->

  inject: ->
    $(@patient).append(@payload)
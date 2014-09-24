window.Graphbox ?= {}

class Graphbox.Injector
  constructor: (@payload, @patient) ->

  inject: ->
    $(@patient).append(@payload)
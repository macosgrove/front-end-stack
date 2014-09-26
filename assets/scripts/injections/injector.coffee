window.Graphbox ?= {}

class Graphbox.Injector
  constructor: (@payload, @patient, @method) ->

  inject: ->
    switch @method
      when "append" then $(@patient).append @payload
      when "after"  then $(@payload).insertAfter $(@patient)
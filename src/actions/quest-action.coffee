Flux = require 'material-flux'
keys = require '../keys'

module.exports =
class QuestAction extends Flux.Action
  constructor: ->
    super

  sampleQuest: ->
    @dispatch keys.sampleQuest

  changeAssign: ->
    @dispatch keys.changeAssign

  nextQuest: ->
    @dispatch keys.nextQuest

  failQuest: ->
    @dispatch keys.failQuest

  toggleMirror: (toggle) ->
    @dispatch keys.toggleMirror, toggle

  toggleAssign: (toggle) ->
    @dispatch keys.toggleAssign, toggle

  toggleDeleteFilter: (toggle, toggle_filter) ->
    @dispatch keys.toggleDeleteFilter, toggle, toggle_filter

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

  toggleMirror: ->
    @dispatch keys.toggleMirror

  toggleAssign: ->
    @dispatch keys.toggleAssign

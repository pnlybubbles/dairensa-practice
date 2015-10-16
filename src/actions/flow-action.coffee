Flux = require 'material-flux'
keys = require '../keys'

module.exports =
class FlowAction extends Flux.Action
  constructor: ->
    super

  startQuest: ->
    @dispatch(keys.updateQuestStatus, true)

  endQuest: ->
    @dispatch(keys.updateQuestStatus, false)

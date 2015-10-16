Flux = require 'material-flux'
keys = require '../keys'

module.exports =
class FlowStore extends Flux.Store
  constructor: (context) ->
    super context
    @state =
      questStatus: false
    @register keys.updateQuestStatus, @updateQuestStatus

  updateQuestStatus: (status) ->
    # status: true=>started, false=>ended
    @setState
      questStatus: status

  get: ->
    @state

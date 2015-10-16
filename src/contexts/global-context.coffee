Flux = require 'material-flux'
BoardAction = require '../actions/board-action'
BoardStore = require '../stores/board-store'
FlowAction = require '../actions/flow-action'
FlowStore = require '../stores/flow-store'
QuestAction = require '../actions/quest-action'
QuestStore = require '../stores/quest-store'

module.exports =
class GlobalContext extends Flux.Context
  constructor: ->
    super
    @boardAction = new BoardAction(@)
    @boardStore = new BoardStore(@)
    @flowAction = new FlowAction(@)
    @flowStore = new FlowStore(@)
    @questAction = new QuestAction(@)
    @questStore = new QuestStore(@)

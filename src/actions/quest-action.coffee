Flux = require 'material-flux'
keys = require '../keys'
dairensaLog = require '../dairensa'

module.exports =
class QuestAction extends Flux.Action
  constructor: ->
    super

  initQuest: ->
    quests = []
    for i in [0..9]
      quests.push dairensaLog[Math.floor(Math.random() * dairensaLog.length)]

    @changeAssign()

    @dispatch(keys.setQuest, quests)

  changeAssign: ->
    assign = {0: 0}
    assign_for = ['blank', 'red', 'blue', 'green', 'yellow', 'purple', 'pink']
    for i in [1..6]
      assign[i] = assign_for.pop()

    @dispatch(keys.setAssign, assign)

  nextQuest: ->
    @dispatch(keys.nextQuest)

  failQuest: ->
    @dispatch(keys.failQuest)

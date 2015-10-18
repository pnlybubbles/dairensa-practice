Flux = require 'material-flux'
keys = require '../keys'
dairensaLog = require '../dairensa'
clone = require 'lodash.clone'

module.exports =
class QuestAction extends Flux.Action
  constructor: ->
    super

  initQuest: ->
    quests = []
    for i in [0..9]
      q = clone dairensaLog[Math.floor(Math.random() * dairensaLog.length)]
      # reverse
      if Math.round(Math.random()) == 0
        q.board = q.board.map (row) -> row.reverse()
        q.delete_arr = q.delete_arr.map (c) -> [7 - c[0], c[1]]
      quests.push q

    @changeAssign()

    @dispatch(keys.setQuest, quests)

  changeAssign: ->
    assign = {0: 'blank'}
    assign_for = ['red', 'blue', 'green', 'yellow', 'purple']
    for i in [1..5]
      assign[i] = assign_for.splice(Math.floor(Math.random() * assign_for.length), 1)[0]
    console.log assign
    @dispatch(keys.setAssign, assign)

  nextQuest: ->
    @changeAssign()

    @dispatch(keys.nextQuest)

  failQuest: ->
    @dispatch(keys.failQuest)

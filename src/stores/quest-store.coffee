Flux = require 'material-flux'
keys = require '../keys'

module.exports =
class QuestStore extends Flux.Store
  constructor: (context) ->
    super context
    @state =
      quest_index: 0
      quests: []
      now_quest: null
      assign: {0: 'blank', 1: 'red', 2: 'blue', 3: 'green', 4: 'yellow', 5: 'purple', 6: 'pink'}
      failed: false
    @register keys.updateQuestStatus, @updateQuestStatus
    @register keys.setQuest, @setQuest
    @register keys.nextQuest, @nextQuest
    @register keys.setAssign, @setAssign
    @register keys.failQuest, @failQuest

  setQuest: (quests) ->
    @setState
      quest_index: 0
      quests: quests[1..]
      now_quest: quests[0]

  nextQuest: ->
    @setState
      quest_index: @state.quest_index + 1
      quests: @state.quests[1..]
      now_quest: @state.quests[0]
      failed: false

  failQuest: ->
    console.log 'fail'
    @setState
      failed: true

  setAssign: (assign) ->
    @setState
      assign: assign

  get: ->
    @state

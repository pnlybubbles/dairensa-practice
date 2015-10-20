Flux = require 'material-flux'
keys = require '../keys'
clone = require 'lodash.clone'
dairensaLog = require '../dairensa'

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
      baseMaps: dairensaLog
      mapsCount: dairensaLog.length * 2 * 120
      mirror_enabled: true
      assign_enabled: true
    @register keys.toggleMirror, @toggleMirror
    @register keys.toggleAssign, @toggleAssign
    @register keys.sampleQuest, @sampleQuest
    @register keys.changeAssign, @changeAssign
    @register keys.nextQuest, @nextQuest
    @register keys.failQuest, @failQuest

  toggleMirror: ->
    mirror_enabled = !@state.mirror_enabled
    @setState
      mirror_enabled: mirror_enabled
      mapsCount: (@state.baseMaps.length * (if mirror_enabled then 2 else 1) * (if @state.assign_enabled then 120 else 1))

  toggleAssign: ->
    assign_enabled = !@state.assign_enabled
    @setState
      assign_enabled: assign_enabled
      mapsCount: (@state.baseMaps.length * (if @state.mirror_enabled then 2 else 1) * (if assign_enabled then 120 else 1))

  sampleQuest: ->
    quests = []
    for i in [0..9]
      q = clone @state.baseMaps[Math.floor(Math.random() * @state.baseMaps.length)]
      # reverse
      if Math.round(Math.random()) == 0
        q.board = q.board.map (row) -> row.reverse()
        q.delete_arr = q.delete_arr.map (c) -> [7 - c[0], c[1]]
      quests.push q
    @setState
      quest_index: 0
      quests: quests[1..]
      now_quest: quests[0]

  changeAssign: ->
    assign = {0: 'blank'}
    assign_for = ['red', 'blue', 'green', 'yellow', 'purple']
    for i in [1..5]
      assign[i] = assign_for.splice(Math.floor(Math.random() * assign_for.length), 1)[0]
    @setState
      assign: assign

  nextQuest: ->
    @setState
      quest_index: @state.quest_index + 1
      quests: @state.quests[1..]
      now_quest: @state.quests[0]
      failed: false

  failQuest: ->
    @setState
      failed: true

  get: ->
    @state

Flux = require 'material-flux'
keys = require '../keys'
clone = require 'lodash.clone'
dairensaLog = require '../dairensa'

module.exports =
class QuestStore extends Flux.Store
  constructor: (context) ->
    super context
    filter = {}
    for i in [1..5]
      filter["deleteCount_#{i}"] = []
    filter['deleteColor_same'] = []
    filter['deleteColor_vary'] = []
    filter['deleteLine_straight'] = []
    filter['deleteLine_notStraight'] = []
    dairensaLog.forEach (v, i) ->
      filter["deleteCount_#{v.delete_arr.length}"].push i
      delete_color = v.delete_arr.map (c) -> v.board[c[1]][c[0]]
      if delete_color.filter((v_, i_, self) -> v_ != self[0]).length == 0
        filter['deleteColor_same'].push i
      else
        filter['deleteColor_vary'].push i
      deleteVertical = v.delete_arr
        .map (c) -> c[0]
        .filter (v_, i_, self) -> v_ != self[0]
        .length == 0
      deleteHorizontal = v.delete_arr
        .map (c) -> c[1]
        .filter (v_, i_, self) -> v_ != self[0]
        .length == 0
      deleteSlanting = v.delete_arr[1..]
        .map (c, i_) -> [c[0] - v.delete_arr[i_][0], c[1] - v.delete_arr[i_][1]]
        .filter (v_, i_, self) -> (v_[0] != -1 || v_[0] != 1 || v_[1] != -1 || v_[1] != 1) || v_[0] != self[0][0] || v_[1] != self[0][1]
        .length == 0
      if deleteVertical || deleteHorizontal || deleteSlanting
        filter['deleteLine_straight'].push i
      else
        filter['deleteLine_notStraight'].push i
    @state =
      quest_index: 0
      quests: []
      now_quest: null
      assign: {0: 'blank', 1: 'red', 2: 'blue', 3: 'green', 4: 'yellow', 5: 'purple', 6: 'pink'}
      failed: false
      baseMaps: dairensaLog
      filterdMaps: dairensaLog
      mapsCount: dairensaLog.length * 2 * 120
      mirror_enabled: true
      assign_enabled: true
      applied_filters: ['deleteCount_1', 'deleteCount_2', 'deleteCount_3', 'deleteCount_4', 'deleteCount_5']
      filter: filter
    @register keys.toggleMirror, @toggleMirror
    @register keys.toggleAssign, @toggleAssign
    @register keys.toggleDeleteFilter, @toggleDeleteFilter
    @register keys.sampleQuest, @sampleQuest
    @register keys.changeAssign, @changeAssign
    @register keys.nextQuest, @nextQuest
    @register keys.failQuest, @failQuest

  toggleMirror: (toggle) ->
    @setState
      mirror_enabled: toggle
      mapsCount: (@state.filterdMaps.length * (if toggle then 2 else 1) * (if @state.assign_enabled then 120 else 1))

  toggleAssign: (toggle) ->
    @setState
      assign_enabled: toggle
      mapsCount: (@state.filterdMaps.length * (if @state.mirror_enabled then 2 else 1) * (if toggle then 120 else 1))

  toggleDeleteFilter: (toggle, toggle_filter) ->
    applied_filters = @state.applied_filters
    toggle_filter_index = applied_filters.indexOf toggle_filter
    if toggle && toggle_filter_index == -1
      applied_filters.push toggle_filter
    else if !toggle && toggle_filter_index != -1
      applied_filters.splice(toggle_filter_index, 1)
    filterdMapsIndex = []
    ['deleteCount_1', 'deleteCount_2', 'deleteCount_3', 'deleteCount_4', 'deleteCount_5', 'deleteColor_same', 'deleteColor_vary', 'deleteLine_straight', 'deleteLine_notStraight'].forEach (v) =>
      if applied_filters.indexOf(v) != -1
        switch v
          when 'deleteCount_1', 'deleteCount_2', 'deleteCount_3', 'deleteCount_4', 'deleteCount_5'
            filterdMapsIndex = filterdMapsIndex.concat @state.filter[v]
          when 'deleteColor_same', 'deleteColor_vary', 'deleteLine_straight', 'deleteLine_notStraight'
            filterdMapsIndex = filterdMapsIndex.filter (idx) => @state.filter[v].indexOf(idx) == -1
    @setState
      mapsCount: (filterdMapsIndex.length * (if @state.mirror_enabled then 2 else 1) * (if @state.assign_enabled then 120 else 1))
      filterdMaps: filterdMapsIndex.map (idx) => @state.baseMaps[idx]
      applied_filters: applied_filters

  sampleQuest: ->
    quests = []
    for i in [0..9]
      q = clone @state.filterdMaps[Math.floor(Math.random() * @state.filterdMaps.length)], true
      # reverse
      if @state.mirror_enabled && Math.round(Math.random()) == 0
        q.board = q.board.map (row) -> row.reverse()
        q.delete_arr = q.delete_arr.map (c) -> [7 - c[0], c[1]]
      quests.push q
    if @state.assign_enabled
      @changeAssign()
    console.log quests
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
    if @state.assign_enabled
      @changeAssign()
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

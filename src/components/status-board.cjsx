React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  componentWillMount: ->
    @store = @context.local.questStore
    @setState @store.get()

  clickNextButton: ->
    boardState = @context.local.boardStore.get()
    count = 0
    boardState.marked_board.forEach (row, y) =>
      row.forEach (cell, x) =>
        count += 1 if cell && @state.now_quest.delete_arr.indexOf([x, y])

    if count == @state.now_quest.delete_arr.length
      if @state.quest_index == 9
        @context.local.flowAction.endQuest()
      else
        @context.local.questAction.nextQuest()
    else
      @context.local.questAction.failQuest()

  clickStatus: ->
    @context.local.boardAction.cleanMark()

  render: ->
    <div style={style.root} onClick={@clickStatus.bind(@)}>
      <div style={style.labelBig}>{"#{@state.quest_index} / 10"}</div>
      <div style={style.labelBig}>{"#{@state.now_quest.delete_arr.length}コ消す"}</div>
      {
        if @state.failed
          <div style={[style.labelBig, style.failed]}>Failed</div>
      }
      <div style={style.button} onClick={@clickNextButton.bind(@)}>
        {
          if @state.quest_index == 9
            'End'
          else
            'Next'
        }
      </div>
    </div>

style =
  root:
    paddingBottom: 20
    paddingTop: 20

  button:
    paddingLeft: 20
    paddingRight: 20
    paddingTop: 12
    paddingBottom: 10
    boxShadow: '0 0 3px rgba(0, 0, 0, 0.3)'
    marginBottom: 10
    textAlign: 'center'
    userSelect: 'none'
    cursor: 'pointer'

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

  failed:
    color: '#FC2E1E'

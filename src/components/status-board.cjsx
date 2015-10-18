React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
Button = require './button'

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
        console.log [x, y] if cell

    console.log 'clicked'
    console.log count, @state.now_quest.delete_arr.length

    if count == @state.now_quest.delete_arr.length
      if @state.quest_index == 9
        @context.local.flowAction.endQuest()
      else
        @context.local.questAction.nextQuest()
    else
      @context.local.questAction.failQuest()

  render: ->
    <div style={style.root}>
      <div style={style.labelBig}>{"#{@state.quest_index + 1} / 10"}</div>
      <div style={style.labelBig}>{"#{@state.now_quest.delete_arr.length}コ消す"}</div>
      {
        if @state.failed
          <div style={[style.labelBig, style.failed]}>しっぱい</div>
      }
      <Button onClick={@clickNextButton}>
        {
          if @state.quest_index == 9
            'おわる'
          else
            'つぎ'
        }
      </Button>
    </div>

style =
  root:
    paddingBottom: 20
    paddingTop: 20
    WebkitTapHighlightColor: 'transparent'

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

  failed:
    color: '#FC2E1E'

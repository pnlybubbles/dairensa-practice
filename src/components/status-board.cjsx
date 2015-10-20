React = require 'react'
Radium = require 'radium'
clone = require 'lodash.clone'
baseMixin = require './mixins/base-mixin'
Button = require './button'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  componentWillMount: ->
    @store = @context.local.questStore
    @setState @store.get()

  clickNextButton: ->
    boardState = @context.local.boardStore.get()
    ok = @state.now_quest.delete_arr
      .map (c) -> boardState.marked_board[c[1]][c[0]]
      .every (b) -> b
    if ok
      if @state.quest_index == 9
        @context.local.flowAction.endQuest()
      else
        @context.local.questAction.nextQuest()
    else
      @context.local.questAction.failQuest()

  render: ->
    <div style={style.root}>
      <div style={style.statues}>
        <div style={style.labelBig}>{"#{@state.now_quest.delete_arr.length}コ消す"}</div>
        <div style={style.labelSmall}>{"#{@state.quest_index + 1} / 10"}</div>
        <div style={style.labelSmall}>{"ぷよ数: #{@state.now_quest.count}コ"}</div>
        {
          if @state.failed
            <div style={[style.labelSmall, style.failed]}>しっぱい</div>
        }
      </div>
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
    WebkitTapHighlightColor: 'transparent'

  statues:
    paddingTop: 10
    paddingBottom: 10
    marginBottom: 10

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

  labelSmall:
    fontSize: 14
    marginBottom: 5
    textAlign: 'center'

  failed:
    color: '#FC2E1E'

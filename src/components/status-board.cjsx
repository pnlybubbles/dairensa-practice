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

  componentDidMount: ->
    @startTimer()

  endTimer: ->
    clearInterval @interval if @interval?

  startTimer: ->
    @setState
      timer: 10
    @interval = setInterval =>
      @setState
        timer: @state.timer - 0.1
    , 100


  clickNextButton: ->
    boardState = @context.local.boardStore.get()
    ok = @state.now_quest.delete_arr
      .map (c) -> boardState.marked_board[c[1]][c[0]]
      .every (b) -> b
    if ok
      if @state.quest_index == 9
        @endTimer()
        @context.local.flowAction.endQuest()
      else
        @endTimer()
        @startTimer()
        @context.local.questAction.nextQuest()
    else
      @context.local.questAction.failQuest()

  render: ->
    if @state.timer < 3
      dstyle =
        color: '#D60D05'
    else if @state.timer < 7
      dstyle =
        color: '#D8B008'
    else
      dstyle =
        color: '#000000'
    <div style={style.root}>
      <div style={style.statues}>
        <div style={style.labelBig}>{"#{@state.now_quest.delete_arr.length}コ消す"}</div>
        <div style={style.labelSmall}>{"#{@state.quest_index + 1} / 10"}</div>
        <div style={style.labelSmall}>{"ぷよ数: #{@state.now_quest.count}コ"}</div>
        <div style={[style.labelSmall, dstyle]}>{"タイマー: #{Math.round(@state.timer * 10) / 10} s"}</div>
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

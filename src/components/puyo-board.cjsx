React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
PuyoBoard = require './puyo-board'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  getInitialState: ->
    {
      touched: false
      touched_coord: null
    }

  componentWillMount: ->
    @context.local.boardAction.initBoard(@props.board)
    @store = @context.local.boardStore
    @setState @store.get()

  componentWillReceiveProps: (nextProps) ->
    @context.local.boardAction.initBoard(nextProps.board)

  clickCell: (x, y) ->
    @context.local.boardAction.toggleMarkCell(x, y)

  touchstart: (e, x, y) ->
    e.stopPropagation()
    if (('ontouchstart' in Object.keys(window)) && e.type == 'touchstart') || (!('ontouchstart' in Object.keys(window)) && e.type == 'mousedown')
      @setState
        touched: true
        touched_coord: [x, y]

  touchend: (e, x, y) ->
    e.stopPropagation()
    if (('ontouchstart' in Object.keys(window)) && e.type == 'touchend') || (!('ontouchstart' in Object.keys(window)) && e.type == 'mouseup')
      @clickCell(x, y)
      @setState
        touched: false
        touched_coord: null

  render: ->
    <div style={style.root}>
      <div style={style.board}>
        {
          board_cmp = []
          (@state.board ? DEFAULT_BOARD).forEach (row, y) =>
            row_cmp = []
            row.forEach (cell, x) =>
              if y == 0
                row_cmp.push <div key={"cell-#{x}-#{y}"} style={[style.cell, style.np, style[@props.assign[cell]]]}></div>
              else
                dstyle = {}
                if @state.touched && @state.touched_coord?[0] == x && @state.touched_coord?[1] == y
                  dstyle =
                    borderWidth: 2
                    borderColor: '#fff'
                    backgroundColor: 'rgba(255, 255, 255, 0.2)'
                if @state.marked_board[y][x] == true
                  dstyle =
                    borderWidth: 4
                    borderColor: '#000'
                row_cmp.push do =>
                  <div key={"cell-#{x}-#{y}"} style={[style.cell, style.dp, style[@props.assign[cell]]]} onTouchStart={((e) => @touchstart(e, x, y))} onTouchEnd={((e) => @touchend(e, x, y))} onMouseDown={((e) => @touchstart(e, x, y))} onMouseUp={((e) => @touchend(e, x, y))}>
                    <div style={[style.mark, dstyle]}></div>
                  </div>
            board_cmp.push <div key={"row-#{y}"} style={style.row}>{row_cmp}</div>
          board_cmp
        }
      </div>
    </div>


DEFAULT_BOARD = [
  [0, 0, 0, 0, 0, 0, 0, 0]
  [0, 0, 0, 0, 0, 0, 0, 0]
  [0, 0, 0, 0, 0, 0, 0, 0]
  [0, 0, 0, 0, 0, 0, 0, 0]
  [0, 0, 0, 0, 0, 0, 0, 0]
  [0, 0, 0, 0, 0, 0, 0, 0]
  [0, 0, 0, 0, 0, 0, 0, 0]
]

style =
  root:
    borderWidth: 1
    borderStyle: 'solid'
    borderColor: '#fff'

  board:
    width: 336
    marginLeft: 'auto'
    marginRight: 'auto'

  cell:
    float: 'left'
    borderWidth: 1
    borderStyle: 'solid'
    borderColor: '#fff'

  mark:
    height: 40
    width: 40
    boxSizing: 'border-box'
    borderWidth: 0
    borderStyle: 'solid'
    borderColor: '#fff'

  np:
    height: 20
    width: 40

  dp:
    height: 40
    width: 40

  row:
    overflow: 'hidden'

  blank:
    backgroundColor: 'rgb(255, 255, 255)'
    # backgroundColor: 'rgb(60, 60, 60)'
  red:
    backgroundColor: 'rgb(252, 72, 84)'
  blue:
    backgroundColor: 'rgb(69, 153, 255)'
  green:
    backgroundColor: 'rgb(96, 210, 88)'
  yellow:
    backgroundColor: 'rgb(241, 219, 53)'
  purple:
    backgroundColor: 'rgb(182, 109, 255)'
  pink:
    backgroundColor: 'rgb(250, 119, 255)'


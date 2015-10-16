Flux = require 'material-flux'
keys = require '../keys'

module.exports =
class BoardStore extends Flux.Store
  constructor: (context) ->
    super context
    @state =
      board: null
      marked_board: [
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
      ]
      marked_count: 0
    @register keys.setBoard, @setBoard
    @register keys.toggleMarkCell, @toggleMarkCell
    @register keys.cleanMark, @cleanMark

  setBoard: (board) ->
    @setState
      board: board

  toggleMarkCell: (x, y) ->
    marked_count = @state.marked_count
    marked_board = @state.marked_board

    if y == 0
    else if @state.board[y][x] == 0
    else if marked_count >= 5
    else if marked_count == 0
      marked_count += 1
      marked_board[y][x] = true
    else
      around = []
      around.push(if y - 1 <= 7 - 1 && y - 1 >= 1 then [x, y - 1] else null)
      around.push(if y + 1 <= 7 - 1 && y + 1 >= 1 then [x, y + 1] else null)
      around.push(if x - 1 <= 8 - 1 && x - 1 >= 0 then [x - 1, y] else null)
      around.push(if x + 1 <= 8 - 1 && x + 1 >= 0 then [x + 1, y] else null)
      around.push(if y - 1 <= 7 - 1 && y - 1 >= 1 && x - 1 <= 8 - 1 && x - 1 >= 0 then [x - 1, y - 1] else null)
      around.push(if y + 1 <= 7 - 1 && y + 1 >= 1 && x - 1 <= 8 - 1 && x - 1 >= 0 then [x - 1, y + 1] else null)
      around.push(if y - 1 <= 7 - 1 && y - 1 >= 1 && x + 1 <= 8 - 1 && x + 1 >= 0 then [x + 1, y - 1] else null)
      around.push(if y + 1 <= 7 - 1 && y + 1 >= 1 && x + 1 <= 8 - 1 && x + 1 >= 0 then [x + 1, y + 1] else null)
      ok = false
      for c in around
        if c && marked_board[c[1]][c[0]] == true
          ok = true
          break
      if ok
        marked_board[y][x] = true
        marked_count += 1

    @setState
      marked_count: marked_count
      marked_board: marked_board

  cleanMark: ->
    @setState
      marked_board: [
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
        [false, false, false, false, false, false, false, false]
      ]
      marked_count: 0

  get: ->
    @state

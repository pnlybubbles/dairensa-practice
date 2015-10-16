Flux = require 'material-flux'
keys = require '../keys'

module.exports =
class BoardAction extends Flux.Action
  constructor: ->
    super

  initBoard: (board) ->
    @dispatch(keys.setBoard, board)

  toggleMarkCell: (x, y) ->
    @dispatch(keys.toggleMarkCell, x, y)

  cleanMark: ->
    @dispatch(keys.cleanMark)

  markBoard: (coord_array) ->
    @dispatch(keys.cleanMark)
    for c in coord_array
      @dispatch(keys.toggleMarkCell, c[0], c[1])


React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
PuyoBoard = require './puyo-board'
StatusBoard = require './status-board'
BottomBoard = require './bottom-board'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  componentWillMount: ->
    @store = @context.local.questStore
    @setState @store.get()

  render: ->
    <div style={style.root}>
      <StatusBoard />
      <PuyoBoard board={@state.now_quest?.board} assign={@state.assign} />
      <BottomBoard />
    </div>

style =
  root: {}

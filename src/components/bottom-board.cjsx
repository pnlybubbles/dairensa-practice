React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
dairensa = require '../dairensa'
Button = require './button'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  componentWillMount: ->
    @store = @context.local.questStore
    @setState @store.get()

  showAnswer: ->
    @context.local.boardAction.markBoard(@state.now_quest.delete_arr)

  cleanMark: ->
    @context.local.boardAction.cleanMark()

  render: ->
    <div style={style.root}>
      <Button onClick={@cleanMark}>けす</Button>
      <Button onClick={@showAnswer}>こたえをみる</Button>
    </div>

style =
  root:
    paddingBottom: 20
    paddingTop: 20

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

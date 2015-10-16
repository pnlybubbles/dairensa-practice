React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
dairensa = require '../dairensa'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  startQuest: ->
    @context.local.flowAction.startQuest()
    @context.local.questAction.initQuest()

  render: ->
    <div style={style.root}>
      <div style={style.labelBig}>{"げんざいのデータ: #{dairensa.length}"}</div>
      <div style={style.button} onClick={@startQuest}>Start</div>
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
    textAlign: 'center'
    userSelect: 'none'
    cursor: 'pointer'

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

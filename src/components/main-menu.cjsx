React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
dairensa = require '../dairensa'
Button = require './button'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  startQuest: ->
    @context.local.questAction.initQuest()
    @context.local.flowAction.startQuest()

  render: ->
    <div style={style.root}>
      <div style={style.labelBig}>{"げんざいのデータ: #{dairensa.length}"}</div>
      <Button onClick={@startQuest}>スタート</Button>
    </div>

style =
  root:
    paddingBottom: 20
    paddingTop: 20

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

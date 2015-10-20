React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
dairensa = require '../dairensa'
Button = require './button'
ToggleButtom = require './toggle-button'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  componentWillMount: ->
    @store = @context.local.questStore
    @setState @store.get()

  startQuest: ->
    @context.local.questAction.sampleQuest()
    @context.local.flowAction.startQuest()

  toggleMirror: (e, toggle) ->
    @context.local.questAction.toggleMirror(toggle)

  toggleAssign: (e, toggle) ->
    @context.local.questAction.toggleAssign(toggle)

  render: ->
    <div style={style.root}>
      <div style={style.statues}>
        <div style={style.labelBig}>{"ぷよクエだいれんされんしゅう"}</div>
        <div style={style.labelSmall}>{"げんざいのデータ: #{dairensa.length}"}</div>
        <div style={style.labelSmall}>{"選ばれる譜面の数: #{@state.mapsCount}"}</div>
      </div>
      <Button onClick={@startQuest}>スタート</Button>
      <ToggleButtom defaultToggle={true} onToggle={@toggleMirror}>鏡譜面を含める</ToggleButtom>
      <ToggleButtom defaultToggle={true} onToggle={@toggleAssign}>ランダムな配色</ToggleButtom>
    </div>

style =
  root:
    paddingBottom: 20
    paddingTop: 20

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

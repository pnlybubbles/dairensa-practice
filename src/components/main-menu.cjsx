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

  toggleDeleteFilter: (toggle_filter, e, toggle) ->
    @context.local.questAction.toggleDeleteFilter(toggle, toggle_filter)

  getDeleteFilterToggle: (toggle_filter) ->
    @state.applied_filters.indexOf(toggle_filter) != -1

  render: ->
    <div style={style.root}>
      <div style={style.statues}>
        <div style={style.labelBig}>{"ぷよクエだいれんされんしゅう"}</div>
        <div style={style.labelSmall}>{"げんざいのデータ: #{dairensa.length}"}</div>
        <div style={style.labelSmall}>{"選ばれる譜面の数: #{@state.mapsCount}"}</div>
      </div>
      <div style={style.section}>
        <Button onClick={@startQuest}>スタート</Button>
      </div>
      <div style={style.section}>
        <div style={style.labelSmall}>せってい</div>
        <ToggleButtom toggle={@state.mirror_enabled} onToggle={@toggleMirror}>鏡譜面を含める</ToggleButtom>
        <ToggleButtom toggle={@state.assign_enabled} onToggle={@toggleAssign}>ランダムな配色</ToggleButtom>
      </div>
      <div style={style.section}>
        <div style={style.labelSmall}>フィルタ</div>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteCount_1')} onToggle={@toggleDeleteFilter.bind(@, 'deleteCount_1')}>1コ消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteCount_2')} onToggle={@toggleDeleteFilter.bind(@, 'deleteCount_2')}>2コ消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteCount_3')} onToggle={@toggleDeleteFilter.bind(@, 'deleteCount_3')}>3コ消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteCount_4')} onToggle={@toggleDeleteFilter.bind(@, 'deleteCount_4')}>4コ消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteCount_5')} onToggle={@toggleDeleteFilter.bind(@, 'deleteCount_5')}>5コ消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteColor_same')} onToggle={@toggleDeleteFilter.bind(@, 'deleteColor_same')}>同色消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteColor_vary')} onToggle={@toggleDeleteFilter.bind(@, 'deleteColor_vary')}>異色消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteLine_straight')} onToggle={@toggleDeleteFilter.bind(@, 'deleteLine_straight')}>直線消し</ToggleButtom>
        <ToggleButtom toggle={@getDeleteFilterToggle('deleteLine_notStraight')} onToggle={@toggleDeleteFilter.bind(@, 'deleteLine_notStraight')}>曲がり消し</ToggleButtom>
      </div>
    </div>

style =
  root:
    paddingBottom: 20
    paddingTop: 20

  statues:
    paddingTop: 10
    paddingBottom: 10
    marginBottom: 10
    marginBottom: 10

  section:
    marginBottom: 25

  labelBig:
    fontSize: 20
    marginBottom: 10
    textAlign: 'center'

  labelSmall:
    fontSize: 14
    marginBottom: 5
    textAlign: 'center'

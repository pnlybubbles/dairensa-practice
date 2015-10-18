React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  getInitialState: ->
    {
      touched: false
    }

  touchstart: (e) ->
    e.stopPropagation()
    if (('ontouchstart' in Object.keys(window)) && e.type == 'touchstart') || (!('ontouchstart' in Object.keys(window)) && e.type == 'mousedown')
      @setState
        touched: true

  touchend: (e) ->
    e.stopPropagation()
    if (('ontouchstart' in Object.keys(window)) && e.type == 'touchend') || (!('ontouchstart' in Object.keys(window)) && e.type == 'mouseup')
      @props.onClick()
      @setState
        touched: false

  render: ->
    dstyle = {}
    if @state.touched
      dstyle =
        backgroundColor: '#eee'
    <div style={[style.root, dstyle]} ref='button' onTouchStart={@touchstart} onTouchEnd={@touchend} onMouseDown={@touchstart} onMouseUp={@touchend}>
      {@props.children}
    </div>

style =
  root:
    paddingLeft: 20
    paddingRight: 20
    paddingTop: 11
    paddingBottom: 10
    boxShadow: '0 0 3px rgba(0, 0, 0, 0.3)'
    textAlign: 'center'
    cursor: 'pointer'
    WebkitTapHighlightColor: 'transparent'
    marginTop: 10
    marginBottom: 10

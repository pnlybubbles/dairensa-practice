React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  getInitialState: ->
    {
      active: false
    }

  clickStart: (e) ->
    e.stopPropagation()
    if (('ontouchstart' in Object.keys(window)) && e.type == 'touchstart') || (!('ontouchstart' in Object.keys(window)) && e.type == 'mousedown')
      @setState
        active: true

  clickEnd: (e) ->
    e.stopPropagation()
    if (('ontouchstart' in Object.keys(window)) && e.type == 'touchend') || (!('ontouchstart' in Object.keys(window)) && e.type == 'mouseup')
      if @state.active
        @props.onToggle?(e, !@props.toggle)
        @setState
          active: false

  clickCancel: (e) ->
    e.stopPropagation()
    @setState
      active: false

  render: ->
    dstyle = {}
    if @state.active
      dstyle =
        backgroundColor: '#eee'
    if @props.toggle
      toggleStatusStyle =
        backgroundColor: '#555'

    <div style={[style.root, dstyle]} ref='button' onTouchStart={@clickStart} onTouchEnd={@clickEnd} onMouseDown={@touchstart} onMouseUp={@clickEnd} onTouchMove={@clickCancel} onMouseOut={@clickCancel}>
      <span style={style.toggleStatusEdge}>
        <span style={[style.toggleStatusRect, toggleStatusStyle]}></span>
      </span>
      <span style={style.label}>{@props.children}</span>
    </div>

style =
  root:
    paddingLeft: 20
    paddingRight: 20
    paddingTop: 13
    paddingBottom: 10
    boxShadow: '0 0 3px rgba(0, 0, 0, 0.3)'
    textAlign: 'center'
    cursor: 'pointer'
    WebkitTapHighlightColor: 'transparent'
    marginTop: 10
    marginBottom: 10

  toggleStatusEdge:
    display: 'inline-block'
    boxSizing: 'border-box'
    height: 14
    width: 14
    borderWidth: 1
    borderStyle: 'solid'
    borderColor: '#555'
    marginRight: 7
    paddingTop: 1
    paddingBottom: 1
    paddingLeft: 1
    paddingRight: 1
    verticalAlign: 'top'

  toggleStatusRect:
    display: 'block'
    height: 10
    width: 10

  label:
    lineHeight: '16px'
    fontSize: 14
    verticalAlign: 'top'


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
        @props.onClick?()
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
    <div style={[style.root, dstyle]} ref='button' onTouchStart={@clickStart} onTouchEnd={@clickEnd} onMouseDown={@clickStart} onMouseUp={@clickEnd} onTouchMove={@clickCancel} onMouseOut={@clickCancel}>
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

  label:
    fontSize: 14
    lineHeight: '16px'
    verticalAlign: 'top'

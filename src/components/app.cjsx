React = require 'react'
Radium = require 'radium'
baseMixin = require './mixins/base-mixin'
MainMenu = require './main-menu'
Quest = require './quest'

module.exports = Radium React.createClass

  mixins: [baseMixin]

  componentWillMount: ->
    @store = @context.local.flowStore
    @setState @store.get()

  render: ->
    <div style={style.root}>
      {
        if @state.questStatus
          <Quest />
        else
          <MainMenu />
      }
    </div>

style =
  root: {}

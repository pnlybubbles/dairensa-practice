React = require 'react'

module.exports =

  getChildContext: ->
    local: @props.context

  childContextTypes:
    local: React.PropTypes.any

  componentDidMount: ->
    if @store?
      @store.onChange @store.get()

  # contextTypes:
  #   global: React.PropTypes.any

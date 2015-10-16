React = require 'react'

module.exports =

  getChildContext: ->
    global: @props.context

  childContextTypes:
    global: React.PropTypes.any

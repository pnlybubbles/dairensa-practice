React = require 'react'

module.exports =

  contextTypes:
    local: React.PropTypes.any
    global: React.PropTypes.any

  componentDidMount: ->
    if @store?
      @store.onChange =>
        @setState @store.get()

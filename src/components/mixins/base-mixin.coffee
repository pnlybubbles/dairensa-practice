React = require 'react'

module.exports =

  contextTypes:
    local: React.PropTypes.any
    global: React.PropTypes.any

  componentDidMount: ->
    @store?.onChange =>
      @setState @store.get()

  componentWillUnmount: ->
    @store?.removeAllChangeListeners()

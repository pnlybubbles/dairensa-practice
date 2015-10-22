React = require 'react'
Radium = require 'radium'
sectionMixin = require './mixins/section-mixin'
AppComponent = require './app'

module.exports = Radium React.createClass

  mixins: [sectionMixin]

  render: ->
    <AppComponent />

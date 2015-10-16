React = require 'react'
Root = require './components/root'
GlobalContext = require './contexts/global-context'

start = ->
  context = new GlobalContext()
  React.render React.createElement(Root, {context}), document.getElementById('app')

# window.addEventListener 'DOMContentLoaded', ->
start()

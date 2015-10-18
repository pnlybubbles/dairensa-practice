React = require 'react'
ReactDOM = require 'react-dom'
Root = require './components/root'
GlobalContext = require './contexts/global-context'

start = ->
  context = new GlobalContext()
  ReactDOM.render React.createElement(Root, {context}), document.getElementById('app')

# window.addEventListener 'DOMContentLoaded', ->
start()

PythonNoseTestView = require './python-nose-test-view'

module.exports = PythonNoseTest =
  pythonNoseTestView: null

  activate: (state) ->
    @pythonNoseTestView = new PythonNoseTestView(state.pythonNoseTestViewState)

  deactivate: ->
    @pythonNoseTestView.destroy()

  serialize: ->
    pythonNoseTestViewState: @pythonNoseTestView.serialize()

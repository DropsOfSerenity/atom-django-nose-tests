_ = require 'underscore-plus'
{View} = require 'atom-space-pen-views'
testRunner = require './test-runner'
ansiToHtml = require 'ansi-to-html'
djangoManage = require './django-manage'


module.exports =
class PythonNoseTestView extends View
  @content: ->
    @div class: "python-nose-test insert-panel panel-bottom", =>
      @div class: "panel-body", =>
        @h1 'Python Tests'
        @pre "", outlet: "results"

  initialize: (serializeState) ->
    atom.commands.add "atom-workspace", "python-nose-test:toggle", => @toggle()
    atom.commands.add "atom-workspace", "python-nose-test:test-file", => @testFile()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  toggle: ->
    if @hasParent()
      @detach()
    else
      @showPanel()

  showPanel: ->
    unless @hasParent()
      atom.workspace.addBottomPanel(item: @)

  write: (str) =>
    @output ||= ''
    convert = new ansiToHtml(escapeXML: true)
    converted = convert.toHtml(str)
    @output += converted
    @updateBuffer()

  testFile: =>
    @clearAndShowPanel()
    @runner = new testRunner({
      write: @write
    })
    @runner.run()

  clearAndShowPanel: ->
    @output = ''
    @updateBuffer()
    @showPanel()

  updateBuffer: ->
    @results.html(@output)
    @results.parent().scrollTop(@results.innerHeight())

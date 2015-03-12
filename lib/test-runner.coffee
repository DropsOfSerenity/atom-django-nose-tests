shellRunner = require './shell-runner'
djangoManage = require './django-manage'
currentFile = require './current-file'

module.exports=
class TestRunner
  constructor: (params) ->
    @initialize(params)

  initialize: (params) ->
    @params = params
    @currentFile = new currentFile

  run: ->
    dj = new djangoManage
    @manage = dj.discover()
    if !@manage
      @params.write "Couldn't locate manage.py make sure you are inside a django project."
      return

    @shell = new shellRunner({
      write: @params.write
      command: @command
      cwd: @currentFile.cwd
    })
    @shell.run()

    return

  command: =>
    pythonCommand = @currentFile.pythonCommand()
    "#{pythonCommand} #{@manage} test"

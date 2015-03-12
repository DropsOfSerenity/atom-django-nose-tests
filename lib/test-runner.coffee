shellRunner = require './shell-runner'
djangoManage = require './django-manage'
currentFile = require './current-file'

module.exports=
class TestRunner
  constructor: (params) ->
    @init(params)

  init: (params) ->
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
    pythonCommand = "python"
    "#{pythonCommand} #{@manage} test"

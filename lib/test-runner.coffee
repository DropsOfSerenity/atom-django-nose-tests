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
      @params.write "Couldn't locate manage.py"
      return

    @shell = new shellRunner({
      write: @params.write
      command: @command
      cwd: @currentFile.cwd
    })
    @shell.run()

    return

  command: =>
    var pythonCommand = "python"
    "#{pythonCommand} #{@manage} test"

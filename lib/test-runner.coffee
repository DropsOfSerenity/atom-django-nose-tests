shellRunner = require './shell-runner'
djangoManage = require './django-manage'

module.exports=
class TestRunner
  constructor: (params) ->
    @init(params)

  init: (params) ->
    @params = params

  run: ->
    dj = new djangoManage
    manage = dj.discover()
    if !manage
      @params.write "Couldn't locate manage.py"
      return

    @shell = new shellRunner({
      write: @params.write
    })
    @shell.run()

    return

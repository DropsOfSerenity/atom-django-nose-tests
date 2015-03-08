shellRunner = require './shell-runner'

module.exports=
class TestRunner
  constructor: (params) ->
    @init(params)

  init: (params) ->
    @params = params

  run: ->
    @shell = new shellRunner({
      write: @params.write
    })
    @shell.run()

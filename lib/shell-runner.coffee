{BufferedProcess} = require 'atom'

module.exports =
  class ShellRunner
    constructor: (params) ->
      console.log(params)
      @init(params)

    init: (params) ->
      @params = params || throw "Missing ::params argument"
      @write = params.write || throw "Missing ::write parameter"

    run: ->
      @process = @createProcess()

    stdout: (output) =>
      console.log 'params, ' + @params
      @params.write output

    stderr: (output) =>
      @params.write output

    createProcess: =>
      command = 'ps'
      args = ['-ef']
      exit = (code) -> console.log("ps -ef exited with #{code}")

      process = new BufferedProcess({command, args, @stdout, exit})
      process

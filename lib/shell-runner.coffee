{BufferedProcess} = require 'atom'

module.exports =
  class ShellRunner
    constructor: (params) ->
      @initialize(params)

    initialize: (params) ->
      @params = params || throw "Missing ::params argument"
      @write = params.write || throw "Missing ::write parameter"
      console.log @params

    run: ->
      fullCommand = "cd #{@params.cwd()} && #{@params.command()}; exit\n"
      @process = @createProcess(fullCommand)

    stdout: (output) =>
      @params.write output

    stderr: (output) =>
      @params.write output

    createProcess: (fullCommand) =>
      command = 'bash'
      args = ['-c', '-l', fullCommand]
      exit = null

      process = new BufferedProcess(
        command: command,
        args: args,
        options: {},
        stdout: @stdout,
        stderr: @stderr,
        exit: exit)
      process

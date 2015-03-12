module.exports =
class CurrentFile
  cwd: ->
    atom.project.getPaths()[0]

  baseDir: ->
    @cwd().split(path.sep).pop()

  filePath: ->
    @editor() and
    @editor().buffer and
    @editor().buffer.file and
    @editor().buffer.file.path

  editor: ->
    atom.workspace.getActiveTextEditor()

  activeFile: ->
    @_activeFile ||= (fp = @filePath()) and atom.project.relativize(fp)

  currentLine: ->
    @currentLine ||= unless @_currentLine
      cursor = @editor and @editor.getCursor()
      if cursor
        cursor.getBufferRow() + 1
      else
        null

  pythonCommand: ->
    atom.config.get("python-nose-test.#{@baseDir()}Python") || "python"

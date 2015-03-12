fs = require 'fs'
currentFile = require './current-file'

module.exports =
class DjangoManage
  discover: ->
    CurrentFile = new currentFile
    projectDir = CurrentFile.cwd()
    managePy = path.join(projectDir, 'manage.py')

    if !fs.existsSync(managePy)
      return null
    return managePy

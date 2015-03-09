CurrentFile = require '../lib/current-file'
fs = require 'fs'

describe "CurrentFile", ->
  editor = null
  currentFile = null

  setUpPaths = ->
    spyOn(atom.project, 'getPaths').andReturn(["testPath"])
    spyOn(atom.project, 'relativize').andReturn("testDirectory/stuff")

  setUpOpenFile = ->
    editor = { buffer: { file: { path: "file_test.py" }}}
    spyOn(atom.workspace, 'getActiveTextEditor').andReturn(editor)

  setUpWithoutOpenFile = ->
    setUpPaths()
    currentFile = new CurrentFile()

  beforeEach ->
    editor = null
    currentFile = null

  describe "::cwd", ->
    it "it gets the current directory of the file", ->
      console.log(atom.project)

      setUpWithoutOpenFile()
      expect(currentFile.cwd()).toBe("testPath")

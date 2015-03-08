PythonNoseTestView = require '../lib/python-nose-test-view'

describe "PythonNoseTestView", ->
  describe "::write", ->
    it "appends content to the results element", ->
      view = new PythonNoseTestView()
      view.write "test"
      expect(view.results.text()).toBe "test"

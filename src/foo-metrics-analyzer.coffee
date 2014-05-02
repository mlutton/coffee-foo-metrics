fs = require 'fs'
execSync = require 'exec-sync'
tokens = require('coffee-script').tokens
{countBy} = require 'underscore'

class FooMetricAnalyzer
  getMetricsFor: (itemToReportOn) ->
    results = {}
    files = []
    currentFile = {}
    currentFile.fileName = itemToReportOn
    currentFile.timesChanged = @_getTimesChanged(itemToReportOn)
    currentFile.tokens = @_getNumberOfTokens(itemToReportOn)
    files.push currentFile
    results.structure = files
    results
  
  _getTimesChanged: (fileToCheck) ->
    command = "git whatchanged " + fileToCheck + " | grep 'commit' | wc -l"
    output = execSync(command)
    parseInt(output, 10)

  _isLiterate: (fileToCheck) ->
    return /\.litcoffee|\.coffee\.md/i.test(fileToCheck)

  _tokens: (tokens) ->
    tokens.length

  _getNumberOfTokens: (fileToCheck) ->
    file = fs.readFileSync(fileToCheck, "utf8")
    tokenList = tokens(file, { literate: @_isLiterate(fileToCheck)})
    @_tokens(tokenList)

module.exports = {FooMetricAnalyzer}

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
    currentFile.firstCheckInDate = @_getFirstCheckInDate(itemToReportOn)
    currentFile.linesOfCode = @_getLinesOfCode(itemToReportOn)
    currentFile.numberOfMethods = @_getNumberOfMethods(itemToReportOn)
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

  _getLinesOfCode: (fileToCheck) ->
    command = "cat " + fileToCheck + " | wc -l"
    output = execSync(command)
    parseInt(output, 10)

  _getNumberOfMethods: (fileToCheck) ->
    command = "grep -e '->' -e '=>' " + fileToCheck + " | wc -l"
    output = execSync(command)
    parseInt(output, 10)

  _getFirstCheckInDate: (fileToCheck) ->
    command = "git log --date=short --reverse " + fileToCheck + " | grep 'Date' | head -1"
    output = execSync(command)
    dateRegEx = ///
      Date:\s+(\d{4})-(\d{2})-(\d{2})
      ///
    [year, month, date] =  output.match(dateRegEx)[1..3]
    
    new Date(year, month, date).toString()

module.exports = {FooMetricAnalyzer}

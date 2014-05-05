assert = require 'assertive'
{FooMetricAnalyzer} = require '../src/foo-metrics-analyzer'

describe 'Foo Metrics Analyzer', ->
  describe 'analyzing one file', ->
    before ->
      @fileToAnalyze = './test-code/foo-metrics-analyzer.coffee'
      analyzer = new FooMetricAnalyzer()
      @results = analyzer.getMetricsFor(@fileToAnalyze)

    it 'returns one file back in the response structure', ->
      assert.equal 1, @results.structure.length

    it 'returns the file in the same format as how it was passed in', ->
      assert.equal @fileToAnalyze, @results.structure[0].fileName

    it 'includes information on how many times the file has changed', ->
      assert.equal 1, @results.structure[0].timesChanged

    it 'includes information on how many tokens the file has', ->
      assert.equal 230, @results.structure[0].tokens

    it 'includes information on when the file was first checked in', ->
      expectedDate = new Date 2014, 11, 1
      assert.equal expectedDate.toString(), @results.structure[0].firstCheckInDate

    it 'includs the number of lines in a given file', ->
      assert.equal 35, @results.structure[0].linesOfCode

    it 'includes the number of methods in a given file', ->
      assert.equal 5, @results.structure[0].numberOfMethods

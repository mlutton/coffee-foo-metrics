assert = require 'assertive'
{FooMetricAnalyzer} = require '../src/foo-metrics-analyzer'

describe 'Foo Metrics Analyzer', ->
  describe 'analyzing one file', ->
    before ->
      @fileToAnalyze = './src/foo-metrics-analyzer.coffee'
      analyzer = new FooMetricAnalyzer()
      @results = analyzer.getMetricsFor(@fileToAnalyze)

    it 'returns one file back in the response structure', ->
      assert.equal 1, @results.structure.length

    it 'returns the file in the same format as how it was passed in', ->
      assert.equal @fileToAnalyze, @results.structure[0].fileName

    it 'includes information on how many times the file has changed', ->
      assert.equal 1, @results.structure[0].timesChanged

    it 'includes information on how many tokens the file has', ->
      assert.equal 210, @results.structure[0].tokens

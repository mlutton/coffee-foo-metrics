assert = require 'assertive'
{FooMetricAnalyzer} = require '../src/foo-metrics-analyzer'

describe 'Foo Metrics Analyzer', ->
  describe 'analyzing one file', ->
    before ->
      @fileToAnalyze = './src/foo-metrics-analyzer.coffee'

    it 'returns one file back in the response structure', ->
      analyzer = new FooMetricAnalyzer()
      results = analyzer.getMetricsFor(@fileToAnalyze)
      assert.equal 1, results.structure.length
      assert.equal @fileToAnalyze, results.structure[0]

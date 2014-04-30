fs = require 'fs'

class FooMetricAnalyzer
  getMetricsFor: (itemToReportOn) ->
    results = {}
    files = []
    file = fs.lstatSync(itemToReportOn).isFile()
    files.push itemToReportOn
    results.structure = files
    results
    
module.exports = {FooMetricAnalyzer}

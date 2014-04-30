assert = require "assertive"

execSync = require "exec-sync"

describe 'foo-metrics', ->
  it 'prints out the foo metrics', ->
    output = execSync './bin/foo-metrics'
    assert.include "Foo-metrics", output
 
  it 'requires a src parameter', ->
    output = execSync './bin/foo-metrics'
    assert.include "You must specify a src parameter in order to start the analysis", output

  it 'supports passing in a directory to analyze', ->
    output = execSync './bin/foo-metrics src'
    assert.include "Analyzing src directory", output

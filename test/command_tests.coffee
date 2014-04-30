assert = require "assertive"

execSync = require "exec-sync"

describe 'foo-metrics', ->
  it 'prints out help text', ->
    output = execSync './bin/foo-metrics'
    assert.include "Hello world", output


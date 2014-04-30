fs = require 'fs'
{print} = require 'sys'
{exec, spawn} = require 'child_process'

REPORTER = "spec"

build = (callback) ->
  child = exec "coffee --compile --output lib src"
  child.stdout.on 'data', (data) ->
    print data
  child.stderr.on 'data', (data) ->
    print data

task 'compile', 'compiles the source from src to lib', ->
  build()

task 'test', 'runs unit tests for project', (options) ->
  exec 'chmod +x lib/foo.js'
  child = exec "NODE_ENV=test
    ./node_modules/.bin/mocha
    --recursive
    --compilers coffee:coffee-script-redux/register
    --reporter #{REPORTER}
    --require coffee-script
    --colors "
  child.stdout.on 'data', (data) ->
    print data
  child.stderr.on 'data', (data) ->
    print data

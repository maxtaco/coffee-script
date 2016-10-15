return if global.testingBrowser

fs = require 'fs'

# REPL
# ----
Stream = require 'stream'

class MockInputStream extends Stream
  constructor: ->
    @readable = true

  resume: ->

  emitLine: (val) ->
    @emit 'data', new Buffer("#{val}\n")

class MockOutputStream extends Stream
  constructor: ->
    @writable = true
    @written = []

  write: (data) ->
    #console.log 'output write', arguments
    @written.push data

  lastWrite: (fromEnd = -1) ->
    @written[@written.length - 1 + fromEnd].replace /\r?\n$/, ''

# Create a dummy history file
historyFile = '.coffee_history_test'
fs.writeFileSync historyFile, '1 + 2\n'

testRepl = (desc, fn) ->
  input = new MockInputStream
  output = new MockOutputStream
  repl = Repl.start {input, output, historyFile}
  test desc, -> fn input, output, repl

ctrlV = { ctrl: true, name: 'v'}


testRepl 'reads history file', (input, output, repl) ->
  input.emitLine repl.rli.history[0]
  eq '3', output.lastWrite()

testRepl "starts with coffee prompt", (input, output) ->
  eq 'iced> ', output.lastWrite(0)

testRepl "writes eval to output", (input, output) ->
  input.emitLine '1+1'
  eq '2', output.lastWrite()

testRepl "comments are ignored", (input, output) ->
  input.emitLine '1 + 1 #foo'
  eq '2', output.lastWrite()

testRepl "output in inspect mode", (input, output) ->
  input.emitLine '"1 + 1\\n"'
  eq "'1 + 1\\n'", output.lastWrite()

testRepl "variables are saved", (input, output) ->
  input.emitLine "foo = 'foo'"
  input.emitLine 'foobar = "#{foo}bar"'
  eq "'foobar'", output.lastWrite()

if process.version_num <= 5.10
  # Behavior of REPL in Node was changed after 5.11. 5.10 is the last version
  # to not print "undefined" after empty output.
  testRepl "empty command evaluates to undefined", (input, output) ->
    input.emitLine ''
    eq 'undefined', output.lastWrite()

testRepl "undefined is printed in the repl", (input, output) ->
  # console.log returns undefined, which should be printed in REPL as well.
  input.emitLine 'console.log(\'hello world\')'
  eq 'hello world', output.lastWrite(-2)
  eq 'undefined', output.lastWrite(-1)

testRepl "ctrl-v toggles multiline prompt", (input, output) ->
  input.emit 'keypress', null, ctrlV
  eq '----> ', output.lastWrite(0)
  input.emit 'keypress', null, ctrlV
  eq 'iced> ', output.lastWrite(0)

testRepl "multiline continuation changes prompt", (input, output) ->
  input.emit 'keypress', null, ctrlV
  input.emitLine ''
  eq '..... ', output.lastWrite(0)

testRepl "evaluates multiline", (input, output) ->
  # Stubs. Could assert on their use.
  output.cursorTo = (pos) ->
  output.clearLine = ->

  input.emit 'keypress', null, ctrlV
  input.emitLine 'do ->'
  input.emitLine '  1 + 1'
  input.emit 'keypress', null, ctrlV
  eq '2', output.lastWrite()

testRepl "variables in scope are preserved", (input, output) ->
  input.emitLine 'a = 1'
  input.emitLine 'do -> a = 2'
  input.emitLine 'a'
  eq '2', output.lastWrite()

testRepl "existential assignment of previously declared variable", (input, output) ->
  input.emitLine 'a = null'
  input.emitLine 'a ?= 42'
  eq '42', output.lastWrite()

testRepl "keeps running after runtime error", (input, output) ->
  input.emitLine 'a = b'
  input.emitLine 'a'
  eq 'undefined', output.lastWrite()

testRepl "iced: handle awaits", (input, output) ->
  input.emitLine 'a = -> await b defer()'
  # The behavior changed somewhere in between Node 6.20 and Node 6.70,
  # it used to be [Function] but is [Function: a] in 6.70.
  ok ['[Function]', '[Function: a]'].indexOf(output.lastWrite()) != -1, "#{output.lastWrite()} is [Function] or [Function: a]"

process.on 'exit', ->
  fs.unlinkSync historyFile

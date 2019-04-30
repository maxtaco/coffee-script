## v108.0.13 (2019-04-30)
- Fix error on repl exit

## v108.0.12 (2019-04-30)
- Remove mkdirp
- Recompile and fix disagreement between GitHub and npm
- upgrade old buggy modules like browserify and uglify

## v108.0.9

- Bugfix: @zapu's PR for incorrect looping semantics, things like CoffeeScript's `for i in [10...3] by -1`.
- Bugfix: unbreak nested forloops with _positive not scoped properly, reported by @jfgorski

## v108.0.8 (2015-08-27)

- Bugfix: unbreak nested forloops, which confused _next() due to a scope problem

## v108.0.7 (2015-08-01)

- Strip out return value-accumulation from iced loops
- Merge Pull #159 (https://github.com/maxtaco/coffee-script/pull/159)

## v108.0.6 (2015-07-11)

- Introduce a new versioning system to satisfy new npm (v2.11.x):
  - If CoffeeScript was a.b.c, and we're at ICS patch d, then release
    under x.c.d, where x = (100*a+b).

## v1.8.0-e (2015-06-11)

- Close #146: deferral variable with same name as a parameter in outer scope;
  PR by @yjerem
- Close #144: Safer quoting of function names in debugging code.
  PR by @sidthekidder
- Don't allow jison >= 0.4.14, until we patch up to CS 1.9
- Close #155: RequireJS without CoffeeScript global
  PR by @yjerem

## v1.8.0-d (2015-03-01)

- Fix autocb for fat arrow functions. Bug report and PR by @davidbau

## v1.8.0-c (2014-12-7)

- Another attempt to fix #139, this time it hopefully works

## v1.8.0-b (2014-12-6)

Bufixes:

  - Close #139

## v1.8.0-a

- Merge with CS v1.8.0

## v1.7.1-g (2014-09-19)

Bufixes:

  - Close #127

## v1.7.1-f (2014-06-11)

Features:

  - Allow .liticed and iced.md suffices for "literate" iced (via @bwin)
  - Close #123 -- allow debugger to work in a loop

## v1.7.1-e (2014-06-04)

Bugfixes:

  - Fix a problem with registering modules as pointed out by @icflorescu

## v1.7.1-d (2014-06-04)

Bugfixes:

  - Close #121: allow `iced foo.iced` from anywhere, even if you don't have
    `iced-runtime` installed globally or locally -- just make a run mode that
    looks for it internalls to the compiler/interpreter.

Tweaks:

  - Try this: `iced = require('iced-runtime')`, as opposed to:
    `iced = require('iced-runtime').iced;`.  This puts the runtime
    and the library features at the same level. This is more natural
    I think...

## v1.7.1-c (2014-06-03)

Features:

  - Factor out runtime, which is now available via `iced-runtime`
  - Build the browser package via browserify, not via ad-hoc mechanism
  - Build both coffee-script.js and coffee-script-min.js, now renamed
    to iced-coffee-script-#{VERSION}.js and iced-coffee-script-#{VERSION}-min.js
  - Remove other build packages, since now the main library is sucked in with
    browserify.

Warnings:

  - Danger ahead! There's a chance that this release is going to break
    existing software, but it's worth it for the long-haul.  Factoring
    out the runtime means software built with iced has way fewer
    dependencies.

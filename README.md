
                                      ICED

                                       _____       __  __
                                      / ____|     / _|/ _|
     .- ----------- -.               | |     ___ | |_| |_ ___  ___
    (  (ice cubes)    )              | |    / _ \|  _|  _/ _ \/ _ \
    |`-..________ ..-'|              | |___| (_) | | | ||  __/  __/
    |                 |               \_____\___/|_| |_| \___|\___|
    |                 ;--.
    |                (__  \            _____           _       _
    |                 | )  )          / ____|         (_)     | |
    |                 |/  /          | (___   ___ _ __ _ _ __ | |_
    |                 (  /            \___ \ / __| '__| | '_ \| __|
    |                 |/              ____) | (__| |  | | |_) | |_
    |                 |              |_____/ \___|_|  |_| .__/ \__|
     `-.._________..-'                                  | |
                                                        |_|

CoffeeScript is a little language that compiles into JavaScript.
IcedCoffeeScript is a superset of CoffeeScript that adds two new
keywords: `await` and `defer`.

IcedCoffeeScript is based on CoffeeScript V1 - the one without Javascript ES6
support. Based on top of last CoffeeScript V1, version 1.12.8, git commit id:
`943579a23943ce62e8d2e3dbc868f22bac773f36`.

## Iced v3 Alpha

We're current alpha-testing Iced v3, which emits ES6 with `yield`s and generators.
Relative to Iced v2, this version stays much closer to the CoffeeScript main body of
code, and emits much simpler code. The downside is that the target must run ES6, or
be transpiled into ES5 with a further step not handled by this package.

## How to Build

```
./bin/cake build
```

## Installation

If you have the node package manager, npm, installed:

```shell
npm install -g iced-coffee-script-3
```

Leave off the `-g` if you don't wish to install globally. If you don't wish to use npm:

```shell
git clone -b iced3 https://github.com/maxtaco/coffeescript.git
sudo coffeescript/bin/cake install
```

## Getting Started

Run REPL:

```shell
iced3
```

Execute a script:

```shell
iced3 /path/to/script.iced
```

Compile a script:

```shell
iced3 -c /path/to/script.iced
```

For documentation, usage, and examples, see: http://coffeescript.org/

To suggest a feature or report a bug: http://github.com/maxtaco/coffeescript/issues

The source repository: https://github.com/maxtaco/coffeescript.git

## Note about `source-map-support`

Since v112.8.1 (2019-12-20), IcedCoffeeScript v3 uses `source-map-support`
package to handle location mapping for stack traces for errors coming from
IcedCoffeeScript code. It's enabled by default when using `iced3` to run scripts
or when using `register` to enable IcedCoffeeScript in Node's module system.

To enable it manually (e.g. in environments other than Node.js or when not
using `register`), use the following API:

```
require('iced-coffee-script-3').installSourceMapSupport({})
```

This function can also be called with options for `source-map-support` instead
of an empty object. Available options are described in `source-map-support`
README file.

To use the old error handler, use the following API instead:

```
require('iced-coffee-script-3').installPrepareStackTrace()
```

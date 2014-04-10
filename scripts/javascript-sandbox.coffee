# Description:
#   sandbox - run javascript in a sandbox!
#
# Dependencies:
#   "sandbox": "0.8.3"
#
# Configuration:
#   None
#
# Commands:
#   hubot (js|sandbox) <javascript> - Execute the javascript code
#
# Author:
#   ajacksified

Sandbox = require('sandbox')

module.exports = (robot) ->
  robot.respond /(sandbox|js) (.*)/i, (msg) ->
    sandbox = new Sandbox
    sandbox.run(msg.match[2], (output) ->
      if output.console and output.console.length
        output.console.forEach (line) =>
          msg.send "=> #{line}"
      msg.send output.result
    )
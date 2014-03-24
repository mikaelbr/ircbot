# Description:
#   Jonas awesomeness
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   - Secret plugin :)
#
# Author:
#   mikaelb

module.exports = (robot) ->

  pattern = /(follesoe|follesø|jonas)/gi
  robot.hear new RegExp(pattern), (msg) ->
    askJonas msg, "http://api.icndb.com/jokes/random?firstName=Jonas&lastName=Follesø"

  askJonas = (msg, url) ->
    msg.http(url)
      .get() (err, res, body) ->
        if err
          msg.send "Jonas Follesø says: #{err}"
        else
          message_from_jonas = JSON.parse(body)
          if message_from_jonas.length == 0
            msg.send "Achievement unlocked: Jonas Follesø is quiet!"
          else
            msg.send message_from_jonas.value.joke
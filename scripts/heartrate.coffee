# Description:
#   Get current Heart Rate of a Programmer
#
# Configuration:
#   None
#
# Commands:
#   hubot heartrate
#
# Author:
#   mikaelb

module.exports = (robot) ->
  url = "http://ble-heartrate.herokuapp.com/heartrate"

  errorMessage = "Could not find any pulse. :o"

  robot.respond /heartrate/i, (msg) ->
    getHeartRate msg, url

  printError = (msg, err) ->
    msg.send errorMessage

  getHeartRate = (msg, url) ->
    msg.http(url)
      .get() (err, res, body) ->
        if err
          printError msg, err
        else
          try
            data = JSON.parse(body)
            if !data or !data.heartrate
              msg.send errorMessage
            else
              msg.send "Current heart rate: #{data.heartrate} BPM"

          catch ex
            printError msg, ex

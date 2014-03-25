# Description:
#   Upcoming Meetups in Trondheim Area
#
# Dependencies:
#   "humanize": "0.0.9"
#
# Configuration:
#   None
#
# Commands:
#   hubot meetup (trondheim|trheim|trh)
#
# Author:
#   mikaelb

humanize = require 'humanize'

module.exports = (robot) ->
  url = "http://api.meetup.com/2/open_events?status=upcoming&radius=25.0&order=time&limited_events=False&and_text=False&desc=False&offset=0&format=json&lat=63.4399986267&page=20&time=%2C1w&lon=10.3999996185&sig_id=96523022&sig=4426f7aa6edc1de968f3edd629e8e328b14844ce"

  robot.respond /meetup (trondheim|trheim|trh)/i, (msg) ->
    getMeetups msg, url

  printError = (msg, err) ->
    msg.send "Kunne ikke hente meetups: #{err}"

  printMeetups = (msg, results) ->
    for result in results
      date = humanize.date('d/M - H:i', new Date(result.time));
      msg.send "=> [#{date}] #{result.group.name} (#{result.yes_rsvp_count}/#{result.rsvp_limit}): #{result.name} - #{result.event_url}"

  getMeetups = (msg, url) ->
    msg.http(url)
      .get() (err, res, body) ->
        if err
          printError msg, err
        else
          try
            meetups = JSON.parse(body)
            if meetups.meta.count is 0
              msg.send "Achievement unlocked: Jonas Follesø is quiet!"
            else
              printMeetups msg, meetups.results

          catch ex
            printError msg, ex

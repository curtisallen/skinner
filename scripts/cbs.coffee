# Description:
#   Queries the CBS api for fantasy football info
#
# Commands:
#   hubot top N POSITION - Get the top N players at position (rb, wr, qb, te, def, kicker, flex)

_ = require('underscore')

module.exports = (robot) ->
  robot.hear /top( (\d+))? (.*)/i, (msg) ->
    count = msg.match[2] || 5
    positions = cleanPosistion msg.match[3]
    msg.http("http://api.cbssports.com/fantasy/players/rankings?version=3.0&source=scott_white_roto&SPORT=football&position=#{positions}&response_format=json&timeframe=weekly&limit=#{count}")
      .get() (err, res, body) ->
        players = ( players for players in positions.players for positions in JSON.parse(body).body.rankings.positions )
        for player in _.flatten(players)
          do(player) ->
            msg.send "rank #{player.rank}: #{player.fullname}"


cleanPosistion = (pos) ->
  positions = pos.toUpperCase()
  possiblePosistions = ["RB", "QB", "WR", "TE", "FLEX", "K", "DST"]

  if positions in possiblePosistions
    return positions
  else if positions.match /rb(s)?|runningback(s)?/i
    return "RB"
  else if positions.match /qb(s)?|quarterback(s)?/i
    return "QB"
  else if posisiton.match /wr(s)?|widereciver(s)?/i
    return "WR"
  else if posisiton.match /te(s)?|tightend(s)?/i
    return "TE"
  else if positions.match /defense(s)?|DEF/i
    return "DST"
  else if positions.match /kicker(s)?/i
    return "K"
  else
    return "RB"

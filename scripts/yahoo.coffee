# Description:
#   Queries the Yahoo api for fantasy football info
#
# Commands:
#   hubot top N POSITION - Get the top N players at position (rb, wr, qb, te, def, kicker, flex)
client = require('request')

clientToken = process.env.YAHOO_CLIENT
clientSecret = process.env.YAHOO_SECRET
redirectUrl = process.env.REDIRECT_URL

module.exports = (robot) ->
  clientToken = if process.env.YAHOO_CLIENT?
                  process.env.YAHOO_CLIENT
  clientSecret = if process.env.YAHOO_SECRET?
                  process.env.YAHOO_SECRET
  redirectUrl = if process.env.REDIRECT_URL?
                  process.env.REDIRECT_URL

  unless clientToken?
    robot.logger.info "yahoo: YAHOO_CLIENT not set"
  unless clientSecret?
    robot.logger.info "yahoo: YAHOO_SECRET not set"

  robot.respond /login/i, (msg) ->
    client.get("https://api.login.yahoo.com/oauth2/request_auth?client_id=#{clientToken}&redirect_uri=#{redirectUrl}&response_type=token&language=en-us",
      {followRedirect: false}, (err, res, body) ->
        robot.logger.info err
        robot.logger.info res
        login_url = res.headers['location']
        robot.logger.info "login url #{login_url}"
        msg.send "Please go to this URL and authorize skinner #{login_url}"
    )


    # msg.http("https://api.login.yahoo.com/oauth2/request_auth")
    #   .post(data) (err, res, body) ->
    #     robot.logger.info "Got a status code: #{res.statusCode}"
    #     robot.logger.info body
        # console.log(body)
    msg.send "Please go to this URL to authorize skinner"

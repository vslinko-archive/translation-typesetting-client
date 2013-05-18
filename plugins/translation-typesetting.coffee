superagent = require "superagent"
events = require "events"


class TranslateAPI extends events.EventEmitter
  constructor: (@hostname, @username, @password, @callbackUrl) ->
    super()

  translate: (content, from, to, callback) ->
    req = superagent.post "http://#{@hostname}/sessions"

    req.send username: @username, password: @password

    req.end (res) =>
      return callback(new Error) unless res.ok

      req = superagent.post "http://#{@hostname}/translations"

      req.send
        language: from: from, to: to
        content: content
        "callback-url": @callbackUrl

      req.set Authorization: "Token #{res.body.token}"

      req.end (res) ->
        return callback(new Error) unless res.ok
        callback null, res.body


module.exports = (container, callback) ->
  hostname = container.get "translation api hostname"
  username = container.get "translation api username"
  password = container.get "translation api password"
  callbackUrl = container.get "translation api callback url"
  app = container.get "app"

  api = new TranslateAPI hostname, username, password, callbackUrl
  container.set "translate api", api

  app.post "/translation-callback", (req, res) ->
    api.emit "translation", req.body
    res.send 200

  callback()

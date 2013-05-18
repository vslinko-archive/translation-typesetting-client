cruder = require "cruder"


module.exports = (container, callback) ->
  connection = container.get "connection"
  mongoose = container.get "mongoose"
  app = container.get "app"

  PageSchema = new mongoose.Schema
    content: type: String, require: true
    language: type: String, default: "ru"

  Page = connection.model "pages", PageSchema

  app.get "/pages", (req, res) ->
    Page.find {}, (err, pages) ->
      return res.send 500 if err

      result = {}

      for page in pages
        lang = page.language
        result[lang] = page.content

      res.send result

  app.post "/pages", (req, res) ->
    Page.findOne language: "ru", (err, page) ->
      return res.send 500 if err
      return res.send 400 unless req.body.content

      page.content = req.body.content

      page.save (err) ->
        return res.send 500 if err
        res.send 200

  callback()

symfio = require "symfio"

module.exports = container = symfio "translation-typesetting-client", __dirname

loader = container.get "loader"

loader.use require "symfio-contrib-express"
loader.use require "symfio-contrib-express-logger"
loader.use require "symfio-contrib-mongoose"
loader.use require "./plugins/translation-typesetting-client"

loader.load() if require.main is module

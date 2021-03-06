symfio = require "symfio"

module.exports = container = symfio "translation-typesetting-client", __dirname

loader = container.get "loader"

container.set "components", [
  "jquery#~1.9"
  "angular#~1.0"
  "angular-sanitize#~1.0"
]

loader.use require "symfio-contrib-nconf"
loader.use require "symfio-contrib-express"
loader.use require "symfio-contrib-express-logger"
loader.use require "symfio-contrib-mongoose"
loader.use require "symfio-contrib-assets"
loader.use require "symfio-contrib-bower"
loader.use require "./plugins/translation-typesetting"
loader.use require "./plugins/translation-typesetting-client"
loader.use require "symfio-contrib-fixtures"

loader.load() if require.main is module

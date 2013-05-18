nconf = require "nconf"
path = require "path"


module.exports = (container, callback) ->
  applicationDirectory = container.get "application directory"

  nconf.file path.join applicationDirectory, "config.json"

  for storeName, store of nconf.stores
    for key, value of store.store
      container.set key, value

  callback()

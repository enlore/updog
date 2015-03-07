express = require "express"
app = express()

mongoose = require "mongoose"

# Dumb config object
config = {}
config.env = process.env.ENV or "development"

# Mongo Connection
conn = null

if config.env is "development"
    conn = mongoose.connect "mongodb://localhost/updogDev"

else if config.env is "production"
    conn = mongoose.connect "mongodb://localhost/updog"

goAwayPlz = (e) ->
    conn.close () ->
        console.log "Mongo out!"

    app.close () ->
        console.log "Express out!"

    process.exit()

process.on "SIGINT", goAwayPlz
process.on "SIGTERM", goAwayPlz

siteRouter = require "../site/siteRoute"
app.use "/sites", siteRouter

module.exports = app

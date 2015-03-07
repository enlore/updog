express = require "express"
app = express()

siteRouter = require "../site/siteRoute"

app.use "/sites", siteRouter

module.exports = app

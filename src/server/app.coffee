express = require "express"
app = express()

siteRouter = require "../site/siteRoute"

app.use "/sites", siteRouter

app.listen 3000, () ->
    console.log "Listening on 3000"

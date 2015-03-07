express = require "express"
Router = express.Router

Site = require "../site/site"

siteRouter = Router()

siteRouter.route("/")
    .get (req, res, next) ->
        Site.find {}, (err, docs) ->
            res.json docs

module.exports = siteRouter

express = require "express"
Router = express.Router

Site = require "../site/site"

siteRouter = Router()

siteRouter.route("/")
    .get (req, res, next) ->
        Site.find {}, (err, docs) ->
            if docs.length is 0
                res.statusCode = 404
                res.end "Sorry, no records"

            else if docs.length > 0
                res.json docs

module.exports = siteRouter

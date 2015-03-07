express = require "express"

Router = express.Router

siteRouter = Router()

siteRouter.route("/")
    .get (req, res, next) ->
        res.json "hello"

module.exports = siteRouter

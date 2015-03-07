mongoose    = require "mongoose"
request     = require "superagent"
Schema      = mongoose.Schema

SiteSchema = new Schema
    url: String
    up:
        type: Boolean
        default: false

# checkStatus(callback)
# the callback signature is (err, document)
SiteSchema.methods.checkStatus = (cb) ->
    request.get @url
        .end (res) =>
            if res.statusCode is 200
                @up = true

                @save (err, doc) ->
                    if err
                        cb err
                    cb null, doc

module.exports = Site = mongoose.model "Site", SiteSchema

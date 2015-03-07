should  = require "should"
http    = require "http"
mongoose = require "mongoose"

Site = require "../src/site/site"

before () ->
    conn = mongoose.connect "mongodb://localhost/updogTest"

after () ->
    Site.remove {}, (err) ->
        throw err if err

server = http.createServer (req, res) ->
    if req.url is "/"
        res.statusCode = 200
        res.end "Site is up"

describe "Site", () ->
    site = new Site
        url: "http://elcreativegroup.com"

    it "should have a url", () ->
        site.should.have.property "url"

    it "should have an up property, a bool", () ->
        site.should.have.property "up"

    it "should have false for a default 'up' state", () ->
        site = new Site
            url: ""

        site.up.should.be.false

    describe "checkStatus()", () ->
        it "should set 'up' property to true if site in question is responding with 200", (done) ->
            server.listen 3000, () ->
                site = new Site
                    url: "http://localhost:3000"

                site.checkStatus (err, doc) ->
                    if err
                        done err

                    doc.up.should.be.true
                    done()

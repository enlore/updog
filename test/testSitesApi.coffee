should = require "should"
request = require "supertest"

Site = require "../src/site/site"
sitesApi = require "../src/server/app"

before ->
    Site.create [{url: "http://google.com"}, {"http://elcreativegroup.com"}], (err) ->
        throw err if err

after ->
    Site.remove {}

describe "Sites API", ->
    it "GET / should return JSON of sites", (done) ->
        request sitesApi
            .get "/sites"
            .expect 200
            .expect "content-type", /json/
            .end (err, res) ->
                if err
                    done err

                res.body.should.be.an.Array
                done()

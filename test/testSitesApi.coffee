should = require "should"
request = require "supertest"

Site = require "../src/site/site"
sitesApi = require "../src/server/app"

# need to refine this so I can also run some tests against an empty DB [1]
beforeEach ->
    Site.create [{url: "http://google.com"}, {"http://elcreativegroup.com"}], (err) ->
        throw err if err

afterEach ->
    Site.remove {}

describe "Sites API", ->
    it "GET / should 404 if no records to send", (done) ->
        # [1] Like this one
        Site.remove {}, (err) ->
            request sitesApi
                .get "/sites"
                .expect 404, done

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

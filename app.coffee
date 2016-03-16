express = require 'express'
bodyParser = require 'body-parser'
reload = (require 'require-reload')(require)

fs = require 'fs'
path = require 'path'

app = express()
pagesCache = {}
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: false}))

app.all '*', (req, res) ->
    reqPath = req.path
    if reqPath is '/'
        reqPath = '/index.coffee'
    if reqPath.match /\.coffee$/
        page = reqPath
    else
        matches = reqPath.match /^(.+\.coffee)\//
        page = matches?[1]
    if page
        file = "pages/#{page}"
        stat = fs.statSync file
        ctime = stat.ctime
        cache = pagesCache[page]
        if cache?.ctime isnt ctime
            cache =
                ctime: ctime
                module: reload("./#{file}")
            pagesCache[page] = cache
        cache.module(req, res)
    else
        console.log "Request: #{page or reqPath} not found."
        res.status 404
        .send '404 No Such Page'

httpPort = process.env.PORT or 2048
app.listen httpPort, (err) ->
    if err
        console.error(err)
    else
        console.log "CSP Server Listened on #{httpPort}"
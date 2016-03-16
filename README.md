# CoffeeSP

An app that makes coffeescript + express like PHP scripts.

You can write some .coffee script and use express framework to handle requests.

When you updating coffee pages under `/pages`, CoffeeSP will auto reload them for you.

## Tutorial

Create a file under `/pages` named `first_page.coffee`.

Write page logic like below:

```coffee
module.exports = (req, res) ->
    res.send "You are requesting #{req.path} using CoffeeSP!"
```

And then start CoffeeSP:

```bash
npm start
# or
./node_modules/.bin/coffee app.coffee
```

Visit your first CoffeeSP page in your browser: <http://localhost:2048/first_page.coffee>

## Advanced

### Pages Folder

All request like `/page.coffee/any/path` will send to `pages/page.coffee`.

### Index Page

When user access `/` their request will send to `pages/index.coffee`.

### Environment Variables

CoffeeSP will listen to port 2048 unless you set a valid port in $PORT.
const express = require('express')
const bodyParser = require('body-parser')
const app = express()
const db = require('./queries')
const PORT = process.env.PORT || 5000

// Helps us to parser the JSON to some readable HTML
app.use(bodyParser.json())

// Again helps with displaying the JSON as HTML
app.use(
    bodyParser.urlencoded({
        extended: true
    })
)

// Just a test Return so that when you visit the URL 
// directly you get something
app.get('/', (request, response) => {
    response.json({ info: 'Postgres, Express and Node.js API: PEN Stack' })
})

// Some RESTful APIs that return data from the postgres DB
app.get('/api/countries', db.getCountries)
app.get('/api/newssources', db.getNewsSources)
app.get('/api/newsarticles', db.getNewsArticles)
app.get('/apiv2/newsarticles/:category', db.getNewsArticleByCategory)
app.get('/api/BplPing', db.getLastPingDt)
app.post('/api/UpdateBplPing', db.setLastPingDt)

// Choose which port the app listens on
// N.B. It is important that you use the PORT environmental variable
// from Heroku "process.env.PORT" so that when Heroku starts its
// Dyno it will use the dynamic Port that was assigned
app.listen(PORT, () => {
console.log(`App running on port ${ PORT }.`)
})
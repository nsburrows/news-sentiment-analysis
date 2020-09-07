const Pool = require('pg').Pool
const pool = new Pool({
  user: 'lzthzrdrcaiqpl',
  host: 'ec2-54-225-95-183.compute-1.amazonaws.com',
  database: 'dcc4gcn7sj6qq4',
  password: '888bc8619916b4f02a98692864df2edf308b04e0c39f0349a4e333b2850ea8bb',
  port: 5432,
  ssl: true
})

const getCountries = (request, response) => {
    pool.query('select * from Country', (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const getNewsSources = (request, response) => {
    pool.query('select * from NewsSource', (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const getNewsArticles = (request, response) => {
    pool.query('select * from newsarticles where sentimentscore is not null and newscategory = \'general\' order by sentimentmagnitude desc limit 20', (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const getNewsArticleByCategory = (request, response) => {
    const category = request.params.category
  
    pool.query('select * from NewsArticles where newscategory = $1::text', [category], (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  const setLastPingDt = (request, response) => {

    date = new Date(Date.now() - 14400000)

    var postgresTimestamp = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate() + ' ' + date.getHours() + ':' + date.getMinutes() + ':' + date.getSeconds()
    
    pool.query('update BplPing set LastPingDt = \'' + postgresTimestamp + '\'', (error, results) => {
    //pool.query('update BplPing set LastPingDt = \'2019-09-03 21:00:59\'', (error, results) => {
      if (error) {
        throw error
      }
      response.end("Done")
      //response.end(postgresTimestamp);
    })
  }

  const getLastPingDt = (request, response) => {
    pool.query('select LastPingDt from BplPing', (error, results) => {
      if (error) {
        throw error
      }
      response.status(200).json(results.rows)
    })
  }

  module.exports = {
    getCountries,
    getNewsSources,
    getNewsArticles,
    getNewsArticleByCategory,
    getLastPingDt,
    setLastPingDt
  }

  
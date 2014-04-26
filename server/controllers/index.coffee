Client = require('request-json').JsonClient

client = new Client 'http://localhost:9101'
client.setBasicAuth process.env.NAME, process.env.TOKEN

sendMailToUser = (from, subject, body, html, cb) ->
    data =
        from: from
        subject: subject
        content: body
        html: html?
    client.post 'mail/to-user', data, cb
    client

module.exports.index = (req, res, next) ->
    sendMailToUser 'bot@example.net', 'Some news', 'HEY DUDE', '<h1>HEY DUDE</h1>', (err, headers, body) ->
        if err?
            res.send 'node error when sending the email: ' + err.toString()
            return
        if headers.statusCode != 200
            res.send 'data-system error when sending the email: ' + body.error
            return
        res.send 'email successfully sent'

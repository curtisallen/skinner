var express = require('express');
var app = express();

app.set('port', (process.env.PORT || 5000));

app.get('/auth/yahoo', function(request, response) {
  console.log(request)
  response.sendStatus(200)
});

app.listen(app.get('port'), function() {
  console.log('Node app is running on port', app.get('port'));
});

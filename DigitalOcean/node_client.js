const http = require('http');
http.get({
  hostname: '127.0.0.1',
  port: 8888,
  path: '/',
  agent: false  // create a new agent just for this one request
}, (res) => {
  if(res === 'okay') {
    console.log('The message was ' + res.payload )
  }
});

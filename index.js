const chokidar = require('chokidar');
const fastuiHandler = require('./src/fastui-loader');


try {
  chokidar.watch('./examples').on('all', (event, path) => {
    var result = fastuiHandler(path);
    console.log(result);
    console.log(event, path);
  });
} catch (error) {
  console.log(error);
}

 // 启动 WebSocket Server
//  const wss = new WebSocket.Server({ port: 8080});
//  wss.on("connection", function connection(ws) {
//    // 已经启动Server
//    console.log("ws connection");
//    ws.on("message", function incoming(message) {
//      console.log("received: %s", message);
//    });
//    ws.send("something");
//  });
 
//  console.log("已经启动Sever: %s", "ws://localhost:8080");

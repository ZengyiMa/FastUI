const chokidar = require("chokidar");
const fastuiHandler = require("./src/fastui-loader");
const WebSocket = require("ws");

// 启动 WebSocket Server
const wss = new WebSocket.Server({ port: 8080 });
wss.on("connection", function connection(ws) {
  // 已经启动Server
  console.log("ws connection");
  try {
    chokidar.watch("examples").on("all", (event, path) => {
      var result = fastuiHandler(path);
      console.log(JSON.stringify(result))
      ws.send(JSON.stringify(result));
    });
  } catch (error) {
    console.log(error);
  }

 
});

 console.log("已经启动Sever: %s", "ws://localhost:8080");

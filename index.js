const compiler = require("./src/fastui-template-complier");
const fs = require("fs");
const WebSocket = require("ws");

const file = process.argv[2];
if (!file) {
  console.log("文件不存在，请输入文件参数");
}

const fileData = fs.readFileSync(file).toString();
const templateString = fileData.substring(
  fileData.indexOf("<template>") + 10,
  fileData.indexOf("</template>")
);
const dataString = fileData.substring(
  fileData.indexOf("<data>") + 6,
  fileData.indexOf("</data>")
);

const templateResult = compiler.compile(templateString, {
  whitespace: "condense"
});
const dataObject = JSON.parse(dataString);
console.log(templateResult.ast);
console.log(dataObject);

// 启动 WebSocket Server
const wss = new WebSocket.Server({ port: 8080});
wss.on("connection", function connection(ws) {
  // 已经启动Server
  console.log("ws connection");
  ws.on("message", function incoming(message) {
    console.log("received: %s", message);
  });
  ws.send("something");
});

console.log("已经启动Sever: %s", JSON.stringify(wss));
setTimeout(() => {
    const client = new WebSocket('ws://localhost:8080');
}, 2000);


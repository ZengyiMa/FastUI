const compiler = require("./fastui-template-complier");
const fs = require("fs");
const WebSocket = require("ws");

module.exports = function (file) {
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
      return {"ui":templateResult, "data": dataObject};
      console.log(templateResult.ast);
      console.log(dataObject);
}


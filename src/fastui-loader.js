const compiler = require("./fastui-template-complier");
const fs = require("fs");


function processJSONObject(jsonObject) {
    if (!jsonObject) {
        return;
    }
    if (jsonObject.children) {
        // 处理内嵌的逻辑
        if (jsonObject.children.length === 1) {
            if (jsonObject.children[0].type === 3 && jsonObject.children[0].static === true) {
                jsonObject.nestedAttr = jsonObject.children[0];
            }
        }
        jsonObject.children.forEach(element => {
            processJSONObject(element);
        });
    }
    jsonObject.parent = undefined;

}

module.exports = function (file) {

    try {
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

          processJSONObject(templateResult.ast)
          return {"ui":templateResult.ast, "data": dataObject};
    } catch (error) {
        console.log(error);
    }

}


const compiler = require("./fastui-template-complier");
const fs = require("fs");

function processJSONObject(jsonObject) {
  if (!jsonObject) {
    return;
  }

  // 处理IF条件的循环问题
  if (jsonObject.ifConditions) {
    jsonObject.ifConditions = undefined;
    if (jsonObject.attrsMap["@if"]) {
      jsonObject.attrsMap["@if"] = undefined;
    }
    jsonObject.if = jsonObject.if.substring(2, jsonObject.if.length - 2);
  }

  if (jsonObject.children) {
    // 处理静态内嵌的逻辑
    if (jsonObject.children.length === 1) {
      if (
        jsonObject.children[0].type === 3 &&
        jsonObject.children[0].static === true
      ) {
        // 静态文本类型
        jsonObject.innerText = jsonObject.children[0].text;
        jsonObject.children = undefined;
      } else if (
        jsonObject.children[0].type === 2 &&
        jsonObject.children[0].static === false
      ) {
        // 内联变量
        jsonObject.innerText = jsonObject.children[0].text;
        jsonObject.children = undefined;
      }
    }
    if (jsonObject.children) {
      jsonObject.children.forEach(element => {
        processJSONObject(element);
      });
    }
  }

  // static style 的处理
  if (jsonObject.staticStyle) {
    jsonObject.staticStyle = JSON.parse(jsonObject.staticStyle);
  }

  // 变量提取处理
  if (jsonObject.attrsMap) {
    jsonObject.dynamicAttrs = {};
    const attrsRemoveKey = [];
    for (var key in jsonObject.attrsMap) {
      
      const value = jsonObject.attrsMap[key];
      if (!value) {
          continue;
      }
      if (value.startsWith("{{") && value.endsWith("}}")) {
        // 是变量，提取出来
        jsonObject.dynamicAttrs[key] = value.substring(2, value.length - 2);
        attrsRemoveKey.push(key);
      }
    }
    attrsRemoveKey.forEach(element => {
      jsonObject.attrsMap[element] = undefined;
    });
  }

  // 内联文本的变量提取
  if (
    jsonObject.innerText &&
    jsonObject.innerText.startsWith("{{") &&
    jsonObject.innerText.endsWith("}}")
  ) {
    // 是变量
    jsonObject.dynamicInnerText = jsonObject.innerText.substring(
      2,
      jsonObject.innerText.length - 2
    );
    jsonObject.innerText = undefined;
  }
  jsonObject.parent = undefined;
}

module.exports = function(file) {
  try {
    if (!file) {
      console.log("文件不存在，请输入文件参数");
    }
    const fileData = fs.readFileSync(file).toString();
    var componentResult = compiler.parseComponent(fileData);
    console.log(componentResult);

    // 模板处理
    const templateResult = compiler.compile(componentResult.template.content, {
      whitespace: "condense"
    });
    processJSONObject(templateResult.ast);

    // 数据处理
    var dataResult = null;
    componentResult.customBlocks.forEach(element => {
      if (element.type === "data") {
        // 数据段
        dataResult = JSON.parse(element.content);
      }
    });
    return { ui: templateResult.ast, data: dataResult };
  } catch (error) {
    console.log(error);
  }
};

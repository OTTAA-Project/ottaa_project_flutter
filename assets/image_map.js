const path = require("path");
const fs = require("fs/promises");

async function main() {
  const files = await fs.readdir(path.join(__dirname, "imgs"));

  const dartTypes = files.map(buildImageConst).join("\n");

  let outputFile = `
    class AppImages {
      ${dartTypes}
    }
  `;

  await fs.writeFile(path.join(__dirname, "image_map.dart"), outputFile);
}

function buildImageConst(path) {
  const finalName = buildVariableName(path.split(".")[0]);

  return `
    static const ${finalName} = "assets/imgs/${path}";
  `;
}

function buildVariableName(variable) {
  return (
    "k" +
    variable
      .split("_")
      .map((word) => word[0].toUpperCase() + word.slice(1))
      .join("")
  );
}

(async () => {
  try {
    await main();
  } catch (e) {
    console.log(e);
  }
})();

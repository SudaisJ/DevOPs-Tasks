import fs from "fs";

const user = "Sudais";

const data = {
  message: `Yo ${user}! Your modern Node.js app is running inside Docker 😎`,
  status: "success"
};

fs.writeFileSync("output.json", JSON.stringify(data, null, 2));
console.log("Output written to output.json ✔");

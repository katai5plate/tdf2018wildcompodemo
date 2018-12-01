const __FORMULA = process.argv[2]
const __VARS_START = process.argv[3] || 0;

const parse = require("./parser")

const outputDefine = require("./outputDefine")

const outputMethod = require("./outputMethod")

// --------------------------------------------------

const fs = require("fs");

const source = fs.readFileSync(`${process.cwd()}/${__FORMULA}`, { encoding: "utf-8" });

const ast = parse(source);

const out = [
    `#include "rpgfunc.as"`,
    "", "/* DECLARATION */",
    ...outputDefine(ast, __VARS_START),
    "", 'rem "====="',
    "", "/* PROCESSING */",
    ...outputMethod(ast),
    "", "/* TESTING */",
    `; send 1`,
    `; receive 1`,
    "", "/* SUBMIT */",
    `send`
].join("\n")

console.log(out)

const fname = require("path").parse(__FORMULA).name;

fs.writeFileSync(`${process.cwd()}/dist/${fname}.hsp`, out, { encoding: "utf8" });

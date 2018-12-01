const path = require("path");
const fs = require("fs-extra");
const filepath = `${__dirname}/${path.parse(process.argv[2]).name}.json`;

(async () => {
  let output = [`#include "rpgfunc.as"`];
  const j = (await fs.readJson(filepath));
  // define
  output.push(...[
    `VAR_ID_X=1 : VAR_ID_Y=2 : WAIT_CNT=0`,
  ])
  // animation
  let anime = [];
  j.forEach(item => {
    anime.push(...[
      `varsel VAR_ID_X : var 0,0,${item.x}`,
      `varsel VAR_ID_Y : var 0,0,${item.y}`,
      "pause WAIT_CNT",
    ])
  })
  // close
  output.push(...[
    ...anime,
    ...anime.reverse(),
    "send"
  ]);
  const result = output.reduce(
    (p, c) => p += [null, undefined, "", ":"].includes(c) ? "" : `${c}\n`,
    ""
  );
  console.log(result);
  await fs.mkdirs(`${__dirname}/dist/`);
  await fs.writeFile(`${__dirname}/dist/${path.parse(filepath).name}_pos.hsp`, result);
})()
const path = require("path");
const fs = require("fs-extra");
const num = process.argv[3] || 0;
const filepath = `${__dirname}/${path.parse(process.argv[2]).name}.json`;
const n = x => ![null, undefined, false].includes(x);
const wait = fr => {
  return !!fr ? `pause ${Math.floor(fr)}:`.repeat(
    (f => {
      const ff = `${f}`;
      if (ff.indexOf(".") === -1) return 1;
      return Number(ff.split(".")[1]);
    })(fr)
  ) : ":"
};
const varsel = fp => {
  return `VX=((X*MX)${fp ? "+(W/2)" : ""})-OX:VY=((Y*MY)${fp ? "+(H/2)" : ""})-OY`
}

(async () => {
  let output = [`#include "rpgfunc.as"`];
  const j = (await fs.readJson(filepath))[num];
  // define
  output.push(...[
    `I=${j.id}:N="${j.name}":W=${j.size.w}:H=${j.size.h}`,
    `OX=${j.offset.x}:OY=${j.offset.y}`,
    `MX=${j.offset.mx}:MY=${j.offset.my}`,
    `X=${j.init.x}:Y=${j.init.y}:S=${j.init.s}:A=${j.init.a}`,
    `R=${j.init.color[0]}:G=${j.init.color[1]}:B=${j.init.color[2]}:V=${j.init.color[3]}`,
    `M=${j.init.effect[0]}:E=${j.init.effect[1]}`,
    `VX=X:VY=Y`,
  ])
  // init
  output.push(...[
    varsel(n(j.fixedPosition)),
    "pic I,N,0,VX,VY,0,S,1,A,A,R,G,B,V,M,E",
    "cy"
  ]);
  // animation
  let anime = [];
  j.animation.forEach(item => {
    anime.push(...[
      [
        n(item.x) ? `X=${item.x}:` : "", n(item.y) ? `Y=${item.y}:` : "",
        n(item.s) ? `S=${item.s}:` : "", n(item.a) ? `A=${item.a}` : "",
        n(item.color) ? `R=${item.color[0]}:G=${item.color[1]}:B=${item.color[2]}:V=${item.color[3]}` : "",
        n(item.effect) ? `M=${item.effect[0]}:E=${item.effect[1]}` : "",
      ].join(""),
      varsel(n(j.fixedPosition)),
      "picmove I,0,VX,VY,S,A,A,0,0,R,G,B,V,M,E",
      wait(j.framerate),
    ])
  })
  // close
  output.push(...[
    ...anime,
    ...(n(j.pingpong) ? anime.reverse() : []),
    wait(j.framerate),
    "cyend",
    "send"
  ]);
  const result = output.reduce(
    (p, c) => p += [null, undefined, "", ":"].includes(c) ? "" : `${c}\n`,
    ""
  );
  console.log(result);
  await fs.mkdirs(`${__dirname}/dist/`);
  await fs.writeFile(`${__dirname}/dist/${path.parse(filepath).name}_${num}.hsp`, result);
})()
const path = require("path");
const fs = require("fs-extra");
(async ()=>{
  const json = await fs.readJson(__dirname+"/cube3d.unisim.json");
  let chest = [];
  const head = {
    // "id": 1,
    "name": "ball",
    "framerate": 0.1,
    "size": {
      "w": 100,
      "h": 100
    },
    "fixedPosition": true,
    "pingpong": true,
    "offset": {
      "x": 160,
      "y": 120,
      "mx": 1,
      "my": 1
    },
    "init": {
      "x": 0,
      "y": 0,
      "s": 100,
      "a": 100,
      "color": [100, 100, 100, 100],
      "effect": [0, 5]
    },
    "animation": []
  };
  for(let index in json){
    const j = json[index];
    if([undefined,null].includes(chest[j.i]))chest[j.i] = {...head,id:j.i+1};
    chest[j.i].animation.push(
      {x:j.x,y:j.y,s:(j.z+4)/8*100}
    )
  }
  await fs.writeFile(`${__dirname}/cube3d.multi.json`, JSON.stringify(chest));
})()
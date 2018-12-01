# Animation Frames
## Unity
```csharp
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using System.IO;

public class log : MonoBehaviour {

StreamWriter sw;
public Transform[] tfs;
int fc;

  void Awake(){
    Application.targetFrameRate = 10;
  }

  // Use this for initialization
	void Start () {
    sw = new StreamWriter("./log.json",false);
    sw.WriteLine("");
    sw.Flush();
    sw.Close();
    sw = new StreamWriter("./log.json",true);
    sw.WriteLine("[{}");
    tfs = GetComponentsInChildren<Transform>();
	}
	
	// Update is called once per frame
	void FixedUpdate () {
    for(int i = 0; i < tfs.Length; i++){
      sw.WriteLine(",{\"i\":"+i+",\"x\":"+tfs[i].position.x+",\"y\":"+tfs[i].position.y+",\"z\":"+tfs[i].position.z+"}");
    }
    Debug.Log(fc);
    fc++;
    if(fc>500)EditorApplication.isPlaying = false;
	}
  private void OnApplicationQuit (){
    end();
  }

  void end(){
    sw.WriteLine("]");
    sw.Flush();
    sw.Close();
  }

}
```
## js on chrome at log.txt
```js
var pap = document.body.innerText;
var len = pap.split("\n").length - 2;
var res = JSON
  .parse(pap)
  .slice(1, len / 2)
  .map(({i, x, y, z}) => {
    var range = 7;
    var size = 100,
      half = size / 2;
    if (i === 0) return "pause 0 : ".repeat(3);
    var [xx, yy, zz] = [Math.floor((x / range) * size), Math.floor((y / range) * size), z / range];
    return [
      `varsel ${i+20} : var 0, 0, ${xx+160}, 0`,
      `varsel ${i+30} : var 0, 0, ${yy+120}, 0`,
      `varsel ${i+40} : var 0, 0, ${Math.floor((zz*50)+50)}, 0`,
    ].join("\n");
  });
[
  `#include "rpgfunc.as"`,
  res.join("\n"),
  res.reverse().join("\n"),
  "send",
].join("\n")
```
# PictureProcess
```c
#include "rpgfunc.as"

ZOOM_VAR = 13
X_VAR = 11
Y_VAR = 12

ALFA = 50

ZOOM_DIFF = 1

PIC_NAME = "syabon"

PIC_ID_FROM = 21
PIC_ID_TO = 28+1

for PIC_ID, PIC_ID_FROM, PIC_ID_TO,  1
	pic PIC_ID, PIC_NAME, 1, X_VAR, Y_VAR, 0, 100, 1, 100
next
cy
	for PIC_ID, PIC_ID_FROM, PIC_ID_TO, 1
		for ZOOM, 0, 100, ZOOM_DIFF
			INDEX = PIC_ID - PIC_ID_FROM + 1
			co 1, INDEX+40, 0, ZOOM, 1
				co 1, INDEX+40, 0, ZOOM+ZOOM_DIFF, 4
					if ZOOM < 3 {
						picmove PIC_ID, 1, INDEX+20, INDEX+30, 3, ALFA,, 0, 0
					}else{
						picmove PIC_ID, 1, INDEX+20, INDEX+30, ZOOM, ALFA,, 0, 0
					}
				coend
			coend
		next
		co 1, INDEX+40, 0, ZOOM, 1 : picmove PIC_ID, 1, INDEX+20, INDEX+30, INDEX+40, 100,, 0, 0 : coend
	next
	pause 0
cyend

send
```
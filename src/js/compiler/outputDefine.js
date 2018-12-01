const syntxErr = require("./syntxErr");

module.exports = (fixedScript, varsStart) => {
    // 変数宣言
    let defineIndex = varsStart || 0;
    const defineData = fixedScript
        // letを抽出
        .filter(v => v[0] === "let")
        // データをまとめる
        .reduce((p, c) => {
            const opt = c[3];
            const memo = c.slice(4).join(" ");
            const _c = c
                .slice(1)
                .map(w => Array.isArray(w) ? w : [w])
            let num = _c[1];
            if (num.length !== 1) syntxErr("不正な代入値", _c, num)
            const vars = _c[0];
            const pushData = vars.reduce((p2, c2) => {
                defineIndex++;
                if (!isNaN(c2)) syntxErr("不正な変数名", c, c2)
                return [
                    ...p2,
                    {
                        var: c2,
                        num: isNaN(num[0]) ? num[0] : Number(num[0]),
                        index: defineIndex,
                        opt,
                        memo,
                    }
                ]
            }, [])
            return [
                ...p,
                ...pushData
            ]
        }, [])
    // カンマによる多重宣言の分配
    const defineConvert = defineData
        .map((v, i) => {
            v.note = `let ${v.var} = ${v.num}`;
            if (isNaN(v.num)) {
                const find = defineData.filter(w => w.var === v.num);
                if (find.length === 0) syntxErr("未宣言の変数は代入不可", v, v.num);
                if (find.length !== 1) syntxErr("変数名の重複宣言", v, v.num);
                // const errFind = defineData.slice(i).filter(w => w.var === v.num);
                // if (errFind.length === 0) syntxErr("未定義の変数", v, v.num);
            }
            return v;
        })
    const defineOutput = defineConvert.map(v => {
        const eqVal = isNaN(v.num) ? 1 : 0;
        const scr = `varsel ${v.var} : var 0, ${eqVal}, ${v.num} ;# ${v.note}`;
        let res = "";
        switch (v.opt) {
            case "in": {
                res = `rem "INPUT: ${v.var} ${v.index} ${v.memo}" : ${v.var} = ${v.index} // : ${scr}\n`;
                break;
            };
            case "out": {
                res = `rem "OUTPUT: ${v.var} ${v.index} ${v.memo}" : ${v.var} = ${v.index} : ${scr}\nrem "-----"`;
                break;
            };
            default: {
                res = `${v.var} = ${v.index} : ${scr}`;
                break;
            };
        }
        return res
    })
    return defineOutput
};

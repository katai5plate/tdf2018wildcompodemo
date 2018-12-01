const syntxErr = require("./syntxErr");

const isVar = item => ["number", "string"].includes(typeof item);

const eachSlice = (tar, size) => {
    let arr = []
    for (let i = 0, l = tar.length; i < l; i += size) {
        arr.push(tar.slice(i, i + size))
    }
    return arr
};

module.exports = fixedScript => {
    // 変数宣言
    const output = fixedScript
        // 宣言以外を抽出
        .filter(v => v[0] !== "let")
        // データをまとめる
        .map(args => {
            const arg0 = args[0];
            switch (arg0) {
                // if構文
                case "if": {
                    let [target, ope, than] = args.slice(1);
                    const thanIsVar = !isVar(than) ? -1 : isNaN(than) ? 1 : 0;
                    if (thanIsVar === -1) {
                        syntxErr("不正な値", args, than);
                    }
                    const opeId = ["=", ">=", "<=", ">", "<", "!"].indexOf(ope);
                    return `co 1, ${target}, ${thanIsVar}, ${than}, ${opeId}`;
                };
                case "if.else": { return "coelse" };
                case "if.end": { return "coend" };
                // ループ構文
                case "loop": { return "cy" };
                case "loop.for": {
                    // まだ
                    return "cy";
                    /*
                    varsel count : var 0, 0, INIT
                    cy
                        varsel count : var 1, (C/V), ADD
                        co 1, count, (V&C/V&V), (C/V), OPE
                            cybreak
                        coend
                        =====
                        =====
                    cyend
                     */
                    const [counter, init, ope, than, add] = args.slice(1);
                    return `varsel ${counter} : var 0, 0, ${init} : cy : varsel ${counter} : var 1, (C/V), ${add} : co 1, ${counter}, (V&C/V&V), /*(C/V)*/:${than}, ${ope} : cybreak : coend`
                };
                case "loop.while": { return { type: arg0 } };
                case "loop.repeat": { return { type: arg0 } };
                case "loop.end": { return "cyend" };
                case "loop.break": { return "cybreak" };
                // 命令系
                case "pic.show": { return { type: arg0 } };
                case "pic.move": { return { type: arg0 } };
                case "pic.cls": { return { type: arg0 } };
                // コマンド直接入力
                case ">>>": {
                    return `rem "${args.slice(1).join(" ")}"`;
                }
                case "cmd": {
                    return `${args[1]} ${args.slice(2).toString()}`;
                }
                case "cmdv": {
                    let mes = args
                        .slice(3)
                        .toString();
                    if (mes.indexOf("$0") > -1) {
                        syntxErr("$0は使用不可", args, mes);
                    }
                    const reps = mes
                        .match(/\$\d{1}/g)
                        .map(v => v.replace("$", ""))
                    reps.forEach((r) => { mes = mes.replace(`$${r}`, `"+${args[1][r - 1]}+"`) });
                    return `${args[2]} ${mes}`;
                    // return {
                    //     type: "cmd",
                    //     exec: `${args[2]} ${args.slice(3).toString()}`,
                    //     vars: args[1]
                    // }
                }
                // 演算
                default: {
                    const target = [...(Array.isArray(args[0]) ? args[0] : [args[0]])];
                    const flow = eachSlice(args.slice(1), 2)
                        .map(v => {
                            const [ope, value] = [v[0], v[1]];
                            if (!isVar(value)) {
                                syntxErr("不正な値", args, value);
                            }
                            if (!isNaN(ope) || !"=+-*/%".includes(ope)) {
                                syntxErr("不正な演算子", args, ope);
                            }
                            return {
                                ope, value
                            };
                        })
                    const res = flow.reduce((vv, v) => {
                        let { ope, value } = v;
                        value = isNaN(value) ? value : Number(value);
                        const opeId = "=+-*/%".indexOf(ope);
                        const pushData = target.reduce((p, c) => {
                            return [...p, `varsel ${c} : var ${opeId}, ${isNaN(value) ? 1 : 0}, ${value} ;# ${c} ${ope} ${value}`]
                        }, [])
                        return `${vv === "" ? "" : vv + "\n"}${pushData.join("\n")}`
                    }, "")
                    return res
                };
            }
        })
    return output
};

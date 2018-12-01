module.exports = script => {
    const fixedScript = script
        .replace(/[\n|\r\n]/g, "") // 改行コード削除
        .replace(/#.*?#/g, "") // コメント削除
        // エスケープ(退避)
        .replace(/\$;/g, "<SC>")
        .replace(/\$,/g, "<CM>")
        .replace(/\$_/g, "<SP>")
        .replace(/\$n/g, "<BR>")
        // スクリプト分割
        .split(/;/)
        .filter(v => v.length !== 0) // 空行削除
        // 配列変換
        .map(v => {
            const _v = v
                .replace(/^\s+/g, "")
                .split(/\s/)
                .map(w => {
                    let _w = w
                        // エスケープ(変換)
                        .replace(/<SC>/g, ";")
                        .replace(/<SP>/g, " ")
                        .replace(/<CM>/g, ",")
                        .replace(/<BR>/g, "\\n")
                    if (!!w.match(/,/)) {
                        _w = w.split(/,/).map(x => x.replace("<CM>", ",")).map(x => x.replace(/<CM>/g, ","));
                    }
                    return _w;
                })
            return _v;
        })
    return fixedScript;
};

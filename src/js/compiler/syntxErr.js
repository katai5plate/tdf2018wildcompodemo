module.exports = (mes, args, point) => {
    console.error(
        `[[ SYNTAX ERROR ]] ${mes}: ${JSON.stringify(args)} -> ${point}`
    );
    process.exit();
};

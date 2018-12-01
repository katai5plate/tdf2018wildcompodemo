# COUTION! This code is unverified. #
let actorMapX,actorMapY 0 in position in MAP of actor;
let actorScrX,actorScrY 0 in position in SCREEN of actor;
let targetMapX,targetMapY 0 in position in MAP of picture;
let picX,picY 0 out position in SCREEN of picture;
picX = actorScrX - actorMapX + targetMapX * 16 + 8;
picY = actorScrY - actorMapY + targetMapY * 16 + 8;

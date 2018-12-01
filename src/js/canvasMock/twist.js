const cellLength = 27;

const setup = () => {
  for (let i = 0; i < cellLength; i++) {
    picture.show(i + 1, "twist02", 0, 0);
  }
  return 60;
}
const draw = () => {
  for (let i = 0; i < cellLength; i++) {
    picture.move(i + 1, -320 * ((fc + i) % cellLength), 16 * i);
  }
}
let x;
x = "rock";
let rounds;
let wins;
let loses;
let ties;
console.log("Welcome to rock paper scissors");
console.log("Select how many rounds you would like to play");
function randomNumber(min, max) {
  return Math.floor(Math.random() * (max - min));
}

for (i = 0; i < rounds; i++) {
  let random = random(1, 9);
  x = x.toLowerCase();
  switch (x) {
    case rock:
      if (random <= 3) {
        console.log("rock beats scissors: You win");
      }
      if (random >= 3 && random < 7) {
        console.log("paper beats rock: You lose");
      } else {
        console.log("It's a tie");
      }
      break;

    case paper:
      if (random <= 3) {
        console.log("paper beats rock: You win");
      }
      if (random >= 3 && random < 7) {
        console.log("scissors beats paper: You lose");
      } else {
        console.log("It's a tie");
      }
      break;

    case scissors:
      if (random <= 3) {
        console.log("scissors beats paper: You win");
      }
      if (random >= 3 && random < 7) {
        console.log("rock beats scissors: You lose");
      } else {
        console.log("It's a tie");
      }
      break;
    default:
      console.log("invalid selection, Do Over!");
      i--;
      break;
  }
  console.log(`Current score is: ${wins} wins, ${loses} loses, ${ties} ties.`);
}


console.log("Welcome to rock paper scissors");
console.log("Type playGame() to get started");

function playGame(){
  console.log("Select how many rounds you would like to play");
  let rounds = prompt("Enter number of rounds");
  if(rounds == parseInt(rounds)){
    gamelogic(rounds);
  }
  else{
    console.log('Thats not a number')
   playGame();
  }
  
}

function randomNumber(min, max) {
  return Math.floor(Math.random() * (max - min) + min);
}
//enums not currently in use
const moves ={
  rock: "rock",
  paper: 'paper',
  scissors: 'scissors'
}

function gamelogic(rounds){
  let x;
  let wins = 0;
  let loses = 0;
  let ties = 0;
  for (i = 0; i < rounds; i++) {
    let random = randomNumber(1, 10);
    x = prompt("Enter move").toLowerCase();
    console.log(`you selected ${x}`);
    switch (x) {
      case "rock":
        if (random <= 3) {
          console.log("rock beats scissors: You win");
          wins++;
        }
        else if (random > 3 && random < 7) {
          console.log("paper beats rock: You lose");
          loses++;
        } else {
          console.log("It's a tie");
          ties++;
        }
        break;
  
      case "paper":
        if (random <= 3) {
          console.log("paper beats rock: You win");
          wins++;
        }
        else if (random > 3 && random < 7) {
          console.log("scissors beats paper: You lose");
          loses++;
        } else {
          console.log("It's a tie");
          ties++;
        }
        break;
  
      case "scissors":
        if (random <= 3) {
          console.log("scissors beats paper: You win");
          wins++;
        }
        else if (random > 3 && random < 7) {
          console.log("rock beats scissors: You lose");
          loses++;
        } else {
          console.log("It's a tie");
          ties++;
        }
        break;
      default:
        console.log("invalid selection, Do Over!");
        i--;
        break;
    }
    console.log(`Current score is: ${wins} wins, ${loses} loses, ${ties} ties.`);
  }
  console.log(`Final score is: ${wins} wins, ${loses} loses, ${ties} ties.`);

  console.log('type playGame() to play again')
}


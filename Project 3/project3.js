
function getRadioValue() { 
    let operations = document.getElementsByName('operation'); 
      let selected;
    for(i = 0; i < operations.length; i++) { 
        if(operations[i].checked) {
            selected = operations[i].value; 
        }
        
    } 
    return selected;
    
} 


function calculate(){
    let number1 = document.getElementById("numberOne").value;
    let number2 = document.getElementById("numberTwo").value;
    let operation = getRadioValue();
    console.log(number1);
    console.log(number2);
    console.log(operation);
    if(operation =="add"){
        
        document.getElementById("result").innerHTML = "The result of adding "+number1+ " and "+ number2+ " is "+addNum(number1, number2);
    }
    else if(operation =="sub"){
        document.getElementById("result").innerHTML = "The result of subtracting "+number2+ " from "+ number1+ " is "+ subtractNum(number1, number2);
    }
    else if(operation =="multiply"){
        document.getElementById("result").innerHTML = "The result of multiplying "+number1+ " with "+ number2+ " is "+ multiplyNum(number1, number2);
    }
    else if(operation =="divide"){
        if(number2 != 0){
            document.getElementById("result").innerHTML = "The result of dividing "+number1+ " by "+ number2+ " is "+ divideNum(number1, number2);
        }
        else{
            document.getElementById("result").innerHTML= "Please don't try to divide by 0"
        }
    }
}
function clearNum(){
    document.getElementById("numberOne").value = "";
    document.getElementById("numberOne").focus();
    document.getElementById("numberTwo").value = "";
}

function addNum(number1,number2){
    let sum= +number1 + +number2;
    return sum;
}

function subtractNum(number1,number2){
    let sub= number1 - number2;
    return sub;
}

function multiplyNum(number1,number2){
    let multiple= number1*number2;
    return multiple;
}
function divideNum(number1,number2){
    let divide= number1 / number2;
    return divide;
}
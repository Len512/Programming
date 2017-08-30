// Global Variables 
var pastTimes = [];

// Timer variables
var interval;
var time = 0;
var tensCount = 00;
var secondsCount = 00;

// Timer flags
var wasPaused = true; 

var startButton = document.getElementById('start');
var resetButton = document.getElementById('reset');
var recordButton = document.getElementById('record');
var display = document.getElementById('display');
//var history = document.getElementById('history');
var tens = document.getElementById('tens');
var seconds = document.getElementById('seconds');

// Function Calls
setUp();

// Function definitions

function setUp(){
    for (var i=0; pastTimes.length; i++){
        var p = '<p>'+pastTimes[i]+'</p>';
        display.innerHTML += p;
    }
    var startCallback = function(){
        /**
         * When the stopwatch starts, the wasPaused flag is set to false, 
         * time increases. The next time the startButton is clicked, time 
         * pauses, the wasPaused flag is set to true
         */
        if (wasPaused) {
            clearInterval(interval);
            interval = setInterval(startTimer, 10);
            wasPaused = false;
        } else {
            clearInterval(interval);
            wasPaused = true;
        }
        
    };
    startButton.addEventListener('click', startCallback);
    
    // startButton.addEventListener('click', function(){
    //     /**
    //      * When the stopwatch starts, the wasPaused flag is set to false, 
    //      * time increases. The next time the startButton is clicked, time 
    //      * pauses, the wasPaused flag is set to true
    //      */
    //     if (wasPaused) {
    //         clearInterval(interval);
    //         interval = setInterval(startTimer, 10);
    //         wasPaused = false;
    //     } else {
    //         clearInterval(interval);
    //         wasPaused = true;
    //     }
        
    // });
    var resetCallback = function(){
        clearInterval(interval);
        wasPaused = true;
        tensCount = 00;
        secondsCount = 00;
        tens.innerHTML = "00";
        seconds.innerHTML = "00";
        document.getElementById('historyRows').innerHTML = "";
    };
    resetButton.addEventListener('click', resetCallback);
    var recordCallback = function(){
        var row = document.createElement('tr');
        var cell = document.createElement('td');
        
        var s, t;
        s = secondsCount;
        t = tensCount;
        // Display 0 when number is one digit, 00:00 in case of recording 0 ms
        if (tensCount < 10){
            t = '0' + tensCount;
        }
        if (tensCount == 0 && secondsCount == 0){
            t = '00';
            s = '00';
        }
        if (secondsCount < 10){
            s = '0' + secondsCount;
        }
        // row.innerHTML = s+':'+t;
        var inner = document.createTextNode(s+':'+t);
        cell.appendChild(inner);
        row.appendChild(cell);
        document.getElementById('historyRows').appendChild(row);
    };
    recordButton.addEventListener('click', recordCallback);

    document.onkeydown = function(e){
        switch (e.keyCode) {
            case 83: // 's'
                startCallback();
                break; 
            case 82: // 'r'
                resetCallback();
                break;
            case 84: // 't'
                recordCallback();
                break;
        }
    }
    function startTimer(){
        tensCount++;
        if (tensCount < 10) {
            tens.innerHTML = "0" + tensCount;
        }
        if (tensCount > 9) {
            tens.innerHTML = tensCount;
        }
        if (tensCount > 99) {
            secondsCount++;
            seconds.innerHTML = "0" + secondsCount;
            tensCount = 00;
            tens.innerHTML = "0" + 0;
        }
        if (secondsCount > 9) {
            seconds.innerHTML = secondsCount;
        }
    }
}
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>격투 게임</title>
    <style>
        body {
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #000;
        }

        #game {
            position: relative;
            width: 800px;
            height: 400px;
            background-color: #333;
            border: 2px solid #fff;
        }

        .character {
            position: absolute;
            width: 50px;
            height: 100px;
            background-color: red;
        }

        #player1 {
            left: 50px;
            bottom: 0;
        }

        #player2 {
            right: 50px;
            bottom: 0;
            background-color: blue;
        }
    </style>
</head>
<body>
    <div id="game">
        <div id="player1" class="character"></div>
        <div id="player2" class="character"></div>
    </div>
    <script>
        const player1 = document.getElementById('player1');
        const player2 = document.getElementById('player2');

        let player1Position = 50;
        let player2Position = 700;

        document.addEventListener('keydown', (event) => {
            switch(event.key) {
                case 'ArrowLeft':
                    player2Position -= 10;
                    break;
                case 'ArrowRight':
                    player2Position += 10;
                    break;
                case 'a':
                    player1Position -= 10;
                    break;
                case 'd':
                    player1Position += 10;
                    break;
                case ' ':
                    attack();
                    break;
            }
            updatePositions();
        });

        function updatePositions() {
            player1.style.left = player1Position + 'px';
            player2.style.left = player2Position + 'px';
        }

        function attack() {
            player1.style.backgroundColor = 'yellow';
            setTimeout(() => {
                player1.style.backgroundColor = 'red';
            }, 100);
        }
    </script>
</body>
</html>

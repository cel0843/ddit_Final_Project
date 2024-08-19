<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tekken Style Fighting Game</title>
    <style>
        body {
            margin: 0;
            overflow: hidden;
            background-color: #000;
        }
        canvas {
            background-color: #222;
            display: block;
            margin: 0 auto;
            border: 2px solid white;
        }
        .health-bar {
            position: absolute;
            height: 20px;
            background-color: red;
        }
        .player1-health {
            top: 20px;
            left: 20px;
            width: 200px;
        }
        .player2-health {
            top: 20px;
            right: 20px;
            width: 200px;
        }
        .status {
            position: absolute;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            color: white;
            font-size: 24px;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
    <canvas id="gameCanvas" width="1280" height="720"></canvas>
    <div class="health-bar player1-health" id="player1HealthBar"></div>
    <div class="health-bar player2-health" id="player2HealthBar"></div>
    <div class="status" id="status">Fighting Game</div>
    <script>
        const canvas = document.getElementById('gameCanvas');
        const context = canvas.getContext('2d');

        // 이미지 로드 함수
        function loadImage(src) {
            return new Promise((resolve) => {
                const img = new Image();
                img.src = src;
                img.onload = () => resolve(img);
            });
        }

        // 게임 상태 관리
        const gameState = {
            isGameOver: false,
            winner: null
        };

        // 플레이어 초기 설정
        const player1 = {
            x: 100,
            y: 600,
            width: 50,
            height: 100,
            speed: 5,
            isAttacking: false,
            health: 100,
            maxHealth: 100,
            attackCooldown: 0,
            img: null
        };

        const player2 = {
            x: 1130,
            y: 600,
            width: 50,
            height: 100,
            speed: 5,
            isAttacking: false,
            health: 100,
            maxHealth: 100,
            attackCooldown: 0,
            img: null
        };

        // 키 입력 상태 저장
        const keys = {
            w: false,
            a: false,
            s: false,
            d: false,
            e: false,
            ArrowUp: false,
            ArrowDown: false,
            ArrowLeft: false,
            ArrowRight: false,
            Slash: false
        };

        // 키 입력 이벤트 리스너
        document.addEventListener('keydown', (event) => {
            if (event.key in keys) {
                keys[event.key] = true;
            }
        });

        document.addEventListener('keyup', (event) => {
            if (event.key in keys) {
                keys[event.key] = false;
            }
        });

        // 충돌 감지 함수
        function isColliding(rect1, rect2) {
            return rect1.x < rect2.x + rect2.width &&
                   rect1.x + rect1.width > rect2.x &&
                   rect1.y < rect2.y + rect2.height &&
                   rect1.y + rect1.height > rect2.y;
        }

        // 체력 바 업데이트 함수
        function updateHealthBars() {
            const player1HealthBar = document.getElementById('player1HealthBar');
            const player2HealthBar = document.getElementById('player2HealthBar');

            player1HealthBar.style.width = (player1.health / player1.maxHealth) * 200 + 'px';
            player2HealthBar.style.width = (player2.health / player2.maxHealth) * 200 + 'px';
        }

        // 게임 상태 업데이트
        function checkGameOver() {
            if (player1.health <= 0 || player2.health <= 0) {
                gameState.isGameOver = true;
                gameState.winner = player1.health > 0 ? 'Player 1' : 'Player 2';
                document.getElementById('status').innerText = `${gameState.winner} Wins!`;
            }
        }

        // 게임 업데이트 함수
        function update() {
            if (gameState.isGameOver) return;

            // 플레이어 1 이동
            if (keys.w) player1.y -= player1.speed;
            if (keys.s) player1.y += player1.speed;
            if (keys.a) player1.x -= player1.speed;
            if (keys.d) player1.x += player1.speed;

            // 플레이어 2 이동
            if (keys.ArrowUp) player2.y -= player2.speed;
            if (keys.ArrowDown) player2.y += player2.speed;
            if (keys.ArrowLeft) player2.x -= player2.speed;
            if (keys.ArrowRight) player2.x += player2.speed;

            // 화면 경계 처리
            if (player1.x < 0) player1.x = 0;
            if (player1.y < 0) player1.y = 0;
            if (player1.x + player1.width > canvas.width) player1.x = canvas.width - player1.width;
            if (player1.y + player1.height > canvas.height) player1.y = canvas.height - player1.height;

            if (player2.x < 0) player2.x = 0;
            if (player2.y < 0) player2.y = 0;
            if (player2.x + player2.width > canvas.width) player2.x = canvas.width - player2.width;
            if (player2.y + player2.height > canvas.height) player2.y = canvas.height - player2.height;

            // 공격 상태 처리
            if (keys.e && player1.attackCooldown === 0) {
                player1.isAttacking = true;
                player1.attackCooldown = 20; // 공격 쿨다운 설정
            } else {
                player1.isAttacking = false;
                if (player1.attackCooldown > 0) player1.attackCooldown--;
            }

            if (keys['/'] && player2.attackCooldown === 0) {
                player2.isAttacking = true;
                player2.attackCooldown = 20; // 공격 쿨다운 설정
            } else {
                player2.isAttacking = false;
                if (player2.attackCooldown > 0) player2.attackCooldown--;
            }

            // 충돌 감지 및 체력 감소
            if (isColliding(player1, player2)) {
                if (player1.isAttacking) {
                    player2.health -= 10;
                }
                if (player2.isAttacking) {
                    player1.health -= 10;
                }
            }

            // 체력 바 업데이트
            updateHealthBars();

            // 게임 상태 체크
            checkGameOver();
        }

        // 게임 그리기 함수
        function draw() {
            context.clearRect(0, 0, canvas.width, canvas.height);

            // 플레이어 1 그리기
            context.drawImage(player1.img, player1.x, player1.y, player1.width, player1.height);

            // 플레이어 2 그리기
            context.drawImage(player2.img, player2.x, player2.y, player2.width, player2.height);
        }

        // 게임 루프
        function gameLoop() {
            update();
            draw();
            requestAnimationFrame(gameLoop);
        }

        // 이미지 로드 후 게임 시작
        Promise.all([
            loadImage('path/to/player1.png').then(img => player1.img = img),
            loadImage('path/to/player2.png').then(img => player2.img = img)
        ]).then(() => {
            gameLoop();
        });
    </script>
</body>
</html>

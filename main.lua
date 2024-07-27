local paddleWidth = 20
local paddleHeight = 100
local ballSize = 20
local paddleSpeed = 300
local ballSpeedX = 400
local ballSpeedY = 300

local leftPaddle = { x = 30, y = 300 - paddleHeight / 2 }
local rightPaddle = { x = 770 - paddleWidth, y = 300 - paddleHeight / 2 }
local ball = { x = 400 - ballSize / 2, y = 300 - ballSize / 2, speedX = ballSpeedX, speedY = ballSpeedY }
local leftScore = 0
local rightScore = 0

function love.load()
    love.window.setMode(800, 600)
    love.window.setTitle("Pong")
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        leftPaddle.y = leftPaddle.y - paddleSpeed * dt
    end
    if love.keyboard.isDown('s') then
        leftPaddle.y = leftPaddle.y + paddleSpeed * dt
    end
    if love.keyboard.isDown('up') then
        rightPaddle.y = rightPaddle.y - paddleSpeed * dt
    end
    if love.keyboard.isDown('down') then
        rightPaddle.y = rightPaddle.y + paddleSpeed * dt
    end

    leftPaddle.y = math.max(0, math.min(leftPaddle.y, 600 - paddleHeight))
    rightPaddle.y = math.max(0, math.min(rightPaddle.y, 600 - paddleHeight))

    ball.x = ball.x + ball.speedX * dt
    ball.y = ball.y + ball.speedY * dt

    if ball.y <= 0 or ball.y >= 600 - ballSize then
        ball.speedY = -ball.speedY
    end

    if (ball.x <= leftPaddle.x + paddleWidth and ball.x + ballSize >= leftPaddle.x and
        ball.y + ballSize >= leftPaddle.y and ball.y <= leftPaddle.y + paddleHeight) or
       (ball.x + ballSize >= rightPaddle.x and ball.x <= rightPaddle.x + paddleWidth and
        ball.y + ballSize >= rightPaddle.y and ball.y <= rightPaddle.y + paddleHeight) then
        ball.speedX = -ball.speedX
    end

    if ball.x < 0 then
        rightScore = rightScore + 1
        resetBall()
    elseif ball.x > 800 then
        leftScore = leftScore + 1
        resetBall()
    end
end

function love.draw()
    love.graphics.rectangle('fill', leftPaddle.x, leftPaddle.y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', rightPaddle.x, rightPaddle.y, paddleWidth, paddleHeight)
    love.graphics.rectangle('fill', ball.x, ball.y, ballSize, ballSize)
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.print("Left: " .. leftScore, 10, 10)
    love.graphics.print("Right: " .. rightScore, 720, 10)
end

function resetBall()
    ball.x = 400 - ballSize / 2
    ball.y = 300 - ballSize / 2
    ball.speedX = -ball.speedX
    ball.speedY = ballSpeedY
end

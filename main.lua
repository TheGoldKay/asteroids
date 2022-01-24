Ship = require 'ship'
Bullets = require 'bullet'
Asteroids = require 'asteroids'

function love.load()
    local ship_radius = 50
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    love.window.setMode(screen_width, screen_height, {x = 600, y = 300})
    ship = Ship:new(screen_width/2, screen_height/2, ship_radius)
    bullets = Bullets:new(100, 10)
    astros = Asteroids:new(ship_radius*5)
end 

function love.draw()
    ship:draw()
    bullets:draw()
    astros:draw()
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.window.close()
        os.exit(0)
    end 
end 

function love.update(dt)
    if love.keyboard.isDown('space') then 
        bullets:add(ship.x, ship.y, ship.a[1])
    end 
    ship:update(dt)
    bullets:update(dt)
    astros:create(dt, ship.x, ship.y)
    --astros:update(dt)
    bullets.list = astros:hit_check(bullets.list)
end
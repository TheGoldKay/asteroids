Ship = require 'ship'

function love.load()
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    love.window.setMode(screen_width, screen_height, {x = 600, y = 300})
    ship = Ship:new(screen_width/2, screen_height/2, 50)
end 

function love.draw()
    ship:draw()
end 

function love.keypressed(key)
    if key == 'escape' then 
        love.window.close()
        os.exit(0)
    end 
end 

function love.update(dt)
    ship:update(dt)
end 
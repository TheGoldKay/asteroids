local Bullet = {}

function Bullet:new(x, y, r, a, speed)
    local o = {}
    setmetable(o, self)
    self.__index = self 
    -- set the coordinate of the bullet's center (circle)
    self.x = x 
    self.y = y 
    -- speed of both x'axis and y'axis 
    self.vel = speed 
    -- circle's radius
    self.r = r 
    -- the angle from which the bullet was fired (the ship head's inclination)
    self.a = a 
    -- the bullet will exist till it gets ouf of screen or hits something
    self.alive = true 
    return o 
end 

function Bullet:draw()
    love.graphics.circle('fill', self.x, self.y, self.r) 
end 

function Bullet:update(dt)
    self.x = math.cos(math.rad(self.a)) * self.r * self.vel * dt + self.x 
    self.y = math.sin(math.rad(self.a)) * self.r * self.vel * dt + self.y 
    if self.x < 0 or self.x > love.graphics.getWidth() then 
        self.alive = false  
    elseif self.y < 0 or self.y > love.graphics.getHeight() then 
        self.alive = false  
    end 
end 

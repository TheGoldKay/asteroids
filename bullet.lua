local Bullet = {}
local Bullets = {}

function Bullet:new(x, y, r, a, speed)
    local o = {}
    setmetatable(o, self)
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

function Bullets:new(velocity, radius)
    local o = {}
    setmetatable(o, self)
    self.__index = self 
    self.vel = velocity
    self.r = radius
    -- all of bullets stored after being fired
    self.list = {} 
    self.clock = 0 
    self.timer = 0.08
    return o 
end 

function Bullets:add(x, y, a)
    if self.clock > self.timer then 
        local bullet = Bullet:new(x, y, self.r, a, self.vel)
        table.insert(self.list, bullet)
        self.clock = 0
    end 
end 

function Bullets:update(dt)
    self.clock = self.clock + dt
    for k, v in ipairs(self.list) do 
        self.list[k]:update(dt)
        if not self.list[k].alive then 
            table.remove(self.list, k)
        end 
    end 
end 

function Bullets:draw()
    for k, v in ipairs(self.list) do 
        self.list[k]:draw()
    end 
end 

return Bullets
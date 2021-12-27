local Asteroids = {}

function Asteroids:new()
    local o = {}
    setmetatable(o, self)
    self.__index = self 
    -- list of asteroids floating around (circles)
    self.astros = {}
    self.r_min = 10 
    self.r_max = 100
    self.x_min = 10
    self.y_min = 10
    -- wait 'timer' seconds to create new asteroids
    self.clock = 0
    self.timer = 3 
    return o 
end 

function Asteroids:create(dt)
    self.clock = self.clock + dt 
    if self.clock > self.timer then 
        local x = math.random(self.x_min, love.graphics.getWidth())
        local y = math.random(self.y_min, love.graphics.getHeight())
        local r = math.random(self.r_min, self.r_max)
        table.insert(self.astros, {x, y, r})
        self.clock = 0
    end 
end 

function Asteroids:draw()
    for k, v in ipairs(self.astros) do 
        love.graphics.circle('fill', v[1], v[2], v[3])
    end 
end 

return Asteroids
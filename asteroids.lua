local Asteroids = {}

function Asteroids:new(ship_radius)
    local o = {}
    setmetatable(o, self)
    self.__index = self 
    -- list of asteroids floating around (circles)
    self.astros = {}
    self.r_min = 10 
    self.r_max = 100
    self.x_min = 10
    self.y_min = 10
    self.vel = 1
    -- wait 'timer' seconds to create new asteroids
    self.clock = 0
    self.timer = 1
    -- set min distance from shitp when created
    self.s_radius = ship_radius
    self.min_dist = 50
    return o 
end 

function Asteroids:make_astro(sx, sy)
    local inc = 600
    while true do 
        local x = math.random(self.x_min+inc, love.graphics.getWidth()-inc)
        local y = math.random(self.y_min, love.graphics.getHeight())
        local r = math.random(self.r_min, self.r_max)
        local a = math.random(0, 360)
        if math.sqrt(math.pow(sx - x, 2) + math.pow(sy - y, 2)) > self.s_radius + r + self.min_dist then 
            return {x = x, y = y, r = r, a = a}
        end 
    end 
end 

function Asteroids:create(dt, shipX, shipY)
    self.clock = self.clock + dt 
    if self.clock > self.timer then 
        local astro = self:make_astro(shipX, shipY)
        table.insert(self.astros, astro)
        self.clock = 0
    end 
end 

function Asteroids:divide(astros, i)
    local part = 1;
    while astros[i].r / part > self.r_min*4 do 
        part = part + 1 
    end 
    for i = 1, part, 1 do 
        local a = math.random(0, 360)
        table.insert(astros, {x = astros[i].x, y = astros[i].y, r = astros[i].r/i, a = a})
    end 
    return astros 
end 

function Asteroids:hit_check(bulletList)
    local astros = self.astros
    local bullets = bulletList 
    if astros ~= {} and bullets ~= {} then 
        for i, b in ipairs(bulletList) do 
            for j, a in ipairs(self.astros) do 
                if math.sqrt(math.pow(b.x - a.x, 2) + math.pow(b.y - a.y, 2)) < b.r + a.r then 
                    astros = self:divide(astros, j)
                    table.remove(astros, j)
                    table.remove(bullets, i)
                    break
                end 
            end 
        end 
    end 
    self.astros = astros
    return bullets
end 

function Asteroids:update(dt)
    if self.astros ~= {} then 
        for k, v in ipairs(self.astros) do 
            self.astros[k].x = v.x + math.cos(math.rad(v.a)) * v.r * self.vel * dt 
            self.astros[k].y = v.y + math.sin(math.rad(v.a)) * v.r * self.vel * dt 
            if self.astros[k].x < 0 or self.astros[k].x > love.graphics.getWidth() then 
                table.remove(self.astros, k)
            elseif self.astros[k].y < 0 or self.astros[k].y > love.graphics.getHeight() then 
                table.remove(self.astros, k)
            end 
        end 
    end
end 

function Asteroids:draw()
    for k, v in ipairs(self.astros) do 
        love.graphics.circle('fill', v.x, v.y, v.r)
    end 
end 

return Asteroids
local Ship = {}

function Ship:new(cx, cy, radius)
    local o = {}
    setmetatable(o, self)
    self.__index = self 
    self.x = cx
    self.y = cy 
    self.r = radius
    self.a = {-90, 45, 135}
    self.p = make_points(self.x, self.y, self.r, self.a)
    self.head_radius = 16
    self.vel = 10
    return o
end 

function make_points(cx, cy, radius, angles)
    local gap = 30
    local p = {{cx + math.cos(math.rad(angles[1])) * radius, cy + math.sin(math.rad(angles[1])) * radius}, 
                {cx + math.cos(math.rad(angles[2])) * radius, cy + math.sin(math.rad(angles[2])) * radius}, 
                {cx + math.cos(math.rad(angles[3])) * radius, cy + math.sin(math.rad(angles[3])) * radius}}
    return {p[1][1], p[1][2], p[2][1], p[2][2],
            p[1][1], p[1][2], p[3][1], p[3][2],
            p[2][1], p[2][2], p[3][1], p[3][2]}
end 

function Ship:draw()
    love.graphics.polygon('fill', self.p)
    love.graphics.circle('line', self.x, self.y, self.r)
    love.graphics.circle('line', self.p[1], self.p[2], self.head_radius)
    love.graphics.circle('fill', self.p[1], self.p[2], self.head_radius/2)
end 

function Ship:update(dt)
    local up = 100
    local change = false 
    -- player rotation
    if love.keyboard.isDown('a', 'left') then 
        self.a[1] = self.a[1] - up * dt
        self.a[2] = self.a[2] - up * dt
        self.a[3] = self.a[3] - up * dt
        change = true 
    elseif love.keyboard.isDown('d', 'right') then 
        self.a[1] = self.a[1] + up * dt
        self.a[2] = self.a[2] + up * dt
        self.a[3] = self.a[3] + up * dt
        change = true 
    end 
    if change then 
        self.p = makePoints(self.x, self.y, self.r, self.a)
    end 
    -- player movement (forward)
    if love.keyboard.isDown('w', 'up') then 
        local a = self.a[1]
        dx = math.cos(math.rad(a)) * self.r * self.vel * dt
        dy = math.sin(math.rad(a)) * self.r * self.vel * dt
        self.x = self.x + dx 
        self.y = self.y + dy 
        self.p = makePoints(self.x, self.y, self.r, self.a)
    end 
    -- check boundaries
    
end 

return Ship 
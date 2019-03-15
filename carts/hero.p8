pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

local ps = {}

function _init()
  local gravity = vec2(0, 0.1)

  for i=1,10 do
    local p = particle(10 + rnd(107), 10 + rnd(10))
    p.prevPos += fromPolar(rnd(), rnd())

    add(p.fx, function() return gravity end)
    add(ps, p)
  end
end

function _update()
  for p in all(ps) do
    p.update()

    if p.currPos.x < 10 then
      p.prevPos.x = p.currPos.x
      p.currPos.x = 10
    end

    if p.currPos.x > 117 then
      p.prevPos.x = p.currPos.x
      p.currPos.x = 117
    end

    if p.currPos.y > 117 then
      p.prevPos.y = p.currPos.y
      p.currPos.y = 117
    end
  end
end

function _draw()
  cls(light_gray)
  print(time(), 1, 1, dark_gray)

  circ(64, 64, 8, green)
  circ(64, 58, 1, dark_gray)

  for p in all(ps) do
    p.draw()
  end

  -- if (flr(time()) % 2 == 0) then
  --   limb(62, 60, 0.70, 0.05, red)
  --   limb(66, 60, 0.80, 0.15, dark_blue)
  -- else
  --   limb(65, 60, 0.80, 0.15, red)
  --   limb(63, 60, 0.70, 0.05, dark_blue)
  -- end
end

local __vec2 = {}

function __vec2.__add(a, b)
  return vec2(a.x + b.x, a.y + b.y)
end

function __vec2.__sub(a, b)
  return vec2(a.x - b.x, a.y - b.y)
end

function vec2(x, y)
  local v = {
    x = x,
    y = y,
  }

  setmetatable(v, __vec2)

  return v
end

function fromPolar(angle, radius)
  return vec2(radius * cos(angle), radius * sin(angle))
end

function particle(x, y)
  local p = {
    currPos = vec2(x, y),
    prevPos = vec2(x, y),
    fx = {}
  }

  function p.update()
    local prevVel = p.currPos - p.prevPos
    local currVel = prevVel

    for f in all(p.fx) do
      currVel += f(p)
    end

    p.prevPos = p.currPos
    p.currPos += currVel
  end

  function p.draw()
    circ(p.currPos.x, p.currPos.y, 1, dark_gray)
    -- circ(p.currPos.x, p.currPos.y, 8, dark_gray)
  end

  return p
end

-- function limb(x, y, angle, bend, color)
--   pole(x, y, angle, 4, color)
--   pole(x + 4 * cos(angle), y + 4 * sin(angle), angle + bend, 4, color)
-- end

-- function pole(x, y, angle, length, color)
--   local x2 = x + length * cos(angle)
--   local y2 = y + length * sin(angle)

--   line(x, y, x2, y2, color)
-- end

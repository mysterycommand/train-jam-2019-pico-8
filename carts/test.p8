pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

cors = {}

btns = {}
btns[left] = {}
btns[right] = {}
btns[up] = {}
btns[down] = {}
btns[fire1] = {}
btns[fire2] = {}

function button(btn_id, plyr_id)
  local self = {
    up = true,
    dn = false,
    state = "up",
  }

  function self:update()
    local dn = btn(btn_id, plyr_id)
    local up = not dn

    if (self.up and dn) then
      -- button went down
      self.state = "down"
    end

    if (self.dn and up) then
      -- button came up
      self.state = "up"
    end

    self.up = up
    self.dn = dn
  end

  return self
end

function _init()
  left_btn = button(left, 0)
end

function _update()
  left_btn:update()
end

function _draw()
  cls(light_gray)
end

-- scratch
-- function vec(x, y)

--   return {
--     x = x,
--     y = y,
--   }
-- end

-- function add(a, b)
--   return vec(a.x + b.x, a.y + b.y)
-- end

-- function sub(a, b)
--   return vec(a.x - b.x, a.y - b.y)
-- end

-- function particle(x, y)
--   return {
--     currpos = vec(x, y),
--     prevpos = vec(x, y),
--   }
-- end

-- function update(p)
--   local prevvel = sub(p.currpos, p.prevpos)
--   local currvel = add(prevvel, gravity)
--   local nextpos = add(p.currpos, currvel)

--   p.prevpos = p.currpos
--   p.currpos = nextpos

--   if p.currpos.y > 127 then
--     p.currpos.y = 0
--     p.prevpos.y = -currvel.y
--   end
-- end

-- function draw(p)
--   circ(p.currpos.x, p.currpos.y, 4, indigo)
--   pset(p.currpos.x, p.currpos.y, indigo)
-- end

-- function lerp(a, b, t)
--   return (1 - t) * a + t * b
-- end

-- function bone(x, y, l, a, c)
--   line(x, y, x + l * cos(a), y + l * sin(a), c)
-- end

__gff__
00ff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

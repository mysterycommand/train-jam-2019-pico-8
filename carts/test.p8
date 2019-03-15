pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15



function _init()
  local t = time()

  co = cocreate(function()
    while time() - t < 2 do
      print("hello " .. t .. " : " .. time(), 1, 1, black)
      yield()
    end
  end)
end

function _update()
end

function _draw()
  cls(light_gray)

  if costatus(co) then
    coresume(co)
  end
end

-- scratch

function vec(x, y)
  return {
    x = x,
    y = y,
  }
end

function add(a, b)
  return vec(a.x + b.x, a.y + b.y)
end

function sub(a, b)
  return vec(a.x - b.x, a.y - b.y)
end

function particle(x, y)
  return {
    currpos = vec(x, y),
    prevpos = vec(x, y),
  }
end

function update(p)
  local prevvel = sub(p.currpos, p.prevpos)
  local currvel = add(prevvel, gravity)
  local nextpos = add(p.currpos, currvel)

  p.prevpos = p.currpos
  p.currpos = nextpos

  if p.currpos.y > 127 then
    p.currpos.y = 0
    p.prevpos.y = -currvel.y
  end
end

function draw(p)
  circ(p.currpos.x, p.currpos.y, 4, indigo)
  pset(p.currpos.x, p.currpos.y, indigo)
end

function lerp(a, b, t)
  return (1 - t) * a + t * b
end

function bone(x, y, l, a, c)
  line(x, y, x + l * cos(a), y + l * sin(a), c)
end

__gfx__
00000000333333338000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000300000030800008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700300000030080080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000300000030008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000300000030008800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700300000030080080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000300000030800008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000333333338000000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

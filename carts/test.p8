pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

function _init()
  gravity = vec(0, 0.1)
  p = particle(64, 1)
end

function _update()
  update(p)
end

function _draw()
  cls(light_gray)
  print(time(),1,1,black)

  -- legs
  bone(65, 64, 8, 0.80, dark_blue)
  bone(63, 64, 8, 0.70, blue)

  -- arms
  bone(66, 58, 8, 0.85, dark_blue)
  bone(62, 58, 8, 0.65, blue)

  draw(p)
end

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
    currPos = vec(x, y),
    prevPos = vec(x, y),
  }
end

function update(p)
  local prevVel = sub(p.currPos, p.prevPos)
  local currVel = add(prevVel, gravity)
  local nextPos = add(p.currPos, currVel)

  p.prevPos = p.currPos
  p.currPos = nextPos

  if p.currPos.y > 127 then
    p.currPos.y = 0
    p.prevPos.y = -currVel.y
  end
end

function draw(p)
  circ(p.currPos.x, p.currPos.y, 4, indigo)
  pset(p.currPos.x, p.currPos.y, indigo)
end

function lerp(a, b, t)
  return (1 - t) * a + t * b
end

function bone(x, y, l, a, c)
  line(x, y, x + l * cos(a), y + l * sin(a), c)
end

pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

function _init()
end

function _update()
end

function _draw()
  cls(light_gray)
  print(time(), 1, 1, dark_gray)

  circ(64, 64, 8, green)
  circ(64, 58, 1, dark_gray)

  -- pole(62, 60, 0.70, 4, red)
  -- pole(62 + 4 * cos(0.70), 60 + 4 * sin(0.70), 0.75, 4, red)
  limb(62, 60, 0.70, 0.05, red)

  -- pole(66, 60, 0.80, 4, dark_blue)
  -- pole(66 + 4 * cos(0.80), 60 + 4 * sin(0.80), 0.95, 4, dark_blue)
  limb(66, 60, 0.80, 0.25, dark_blue)
end

function limb(x, y, angle, bend, color)
  pole(x, y, angle, 4, color)
  pole(x + 4 * cos(angle), y + 4 * sin(angle), angle + bend, 4, color)
end

function pole(x, y, angle, length, color)
  local x2 = x + length * cos(angle)
  local y2 = y + length * sin(angle)

  line(x, y, x2, y2, color)
end

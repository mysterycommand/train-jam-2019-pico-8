pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

pi=22/7
loop=0

function _init()
end

function _update()

end

function _draw()
  cls(orange)
  print(time(),1,1,black)
  print(pi,1,9,black)

  loop+=1
  loop%=360

  bone(64, 64, 8, loop / 180, red)
  bone(64, 64, 8, loop / 90, green)
  bone(64, 64, 8, loop / 45, blue)
  bone(64, 64, 8, loop / 60, dark_purple)
end

function bone(x, y, l, a, c)
  line(x, y, x + l * cos(a), y + l * sin(a), c)
end

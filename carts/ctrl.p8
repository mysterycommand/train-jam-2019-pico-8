pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

btn_ids = {
  left,
  right,
  up,
  down,
  fire1,
  fire2,
}

btn_states = {
  up = "up",
  down = "down",
  hold = "hold", -- down + time
  tap = "tap", -- down & up?
  tap_and_hold = "tap_and_hold",
  dbl_tap = "dbl_tap",
  dbl_tap_and_hold = "dbl_tap_and_hold",
}

btn_time = {}
btn_time[left] = { prev = 0, curr = 0, state = btn_states.up }
btn_time[right] = { prev = 0, curr = 0, state = btn_states.up }
btn_time[up] = { prev = 0, curr = 0, state = btn_states.up }
btn_time[down] = { prev = 0, curr = 0, state = btn_states.up }
btn_time[fire1] = { prev = 0, curr = 0, state = btn_states.up }
btn_time[fire2] = { prev = 0, curr = 0, state = btn_states.up }

-- something for later
-- if (costatus(co) != "dead") coresume(co)
-- if (btn(right, 0)) coresume(co, true)
co = cocreate(function(die)
  while true do
    die = yield()
    if (die) return

    print("hi", 64, 64, black)
  end
end)

function get_btn_time(btn_id, player_id)
  if btnp(btn_id, player_id) then
    btn_time[btn_id].prev = btn_time[btn_id].curr
    btn_time[btn_id].curr = time()
  end
end

function get_btn_times()
  for btn_id in all(btn_ids) do
    get_btn_time(btn_id, 0)
  end
end

function get_btn_state(btn_id, player_id)
  local did_press = btn_time[left].curr != 0
  local did_press_before = btn_time[left].prev != 0
  local did_press_recently = btn_time[left].curr - btn_time[left].prev < 0.2

  if btn(btn_id, player_id) then
    -- button is currently down
  else
  end
end

function get_btn_states()
  for btn_id in all(btn_ids) do
    get_btn_state(btn_id, 0)
  end
end

function btns()
  get_btn_times()
  get_btn_states()
end

function _init()

end

function _update()
  btns()

end

function _draw()
  cls(light_gray)
  print(time(), 1, 1, black)
end

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
  up = 0,
  down = 1,
  tap = 2,
  hold = 3,
  tap_and_hold = 4,
  dbl_tap = 5,
  dbl_tap_and_hold = 6,
}

state_labels = {
  [btn_states.up] = "up",
  [btn_states.down] = "down",
  [btn_states.tap] = "tap",
  [btn_states.hold] = "hold",
  [btn_states.tap_and_hold] = "tap and hold",
  [btn_states.dbl_tap] = "double tap",
  [btn_states.dbl_tap_and_hold] = "double tap and hold",
}

btns = {
  [left]  = { label = "\x8b", state = btn_states.up, history = "" },
  [right] = { label = "\x91", state = btn_states.up, history = "" },
  [up]    = { label = "\x94", state = btn_states.up, history = "" },
  [down]  = { label = "\x83", state = btn_states.up, history = "" },
  [fire1] = { label = "\x8e", state = btn_states.up, history = "" },
  [fire2] = { label = "\x97", state = btn_states.up, history = "" },
}

tap = { ["01"] = true }
hold = { ["111111"] = true }

tap_and_holds = {
  ["111112"] = true,
  ["111102"] = true,
}

dbl_taps = {
  ["201201"] = true,
  ["201120"] = true,
  ["201102"] = true,
  ["201112"] = true,
}

dbl_tap_and_holds = {
  ["111115"] = true,
  ["111105"] = true,
}

strs = {}

function init_strs()
  for btn_id in all(btn_ids) do
    strs[btn_id + 1] = { duration = 0, state = 0 }
  end
end

function push_state(btn_id, btn_state)
  btns[btn_id].history = btns[btn_id].state .. btns[btn_id].history
  btns[btn_id].state = btn_state
end

function query_btns(player_id)
  for btn_id in all(btn_ids) do
    local h = btns[btn_id].state .. btns[btn_id].history
    local state

    -- query up or down
    if btn(btn_id, player_id) then
      state = btn_states.down
    else
      state = btn_states.up
    end

    -- detect a "tap" (was down, came up)
    if (tap[sub(h, 0, 2)]) state = btn_states.tap

    -- a "hold" is a down that lasts for 6 frames (~0.2s running at 30fps)
    local did_hold = hold[sub(h, 0, 6)]
    local was_held = btn(btn_id, player_id) and sub(h, 0, 1) == "" .. btn_states.hold
    if (did_hold or was_held) state = btn_states.hold

    -- a "tap and hold" is a tap followed almost immediately by a hold
    local did_tap_and_hold = tap_and_holds[sub(h, 0, 6)]
    local was_tap_and_held = btn(btn_id, player_id) and sub(h, 0, 1) == "" .. btn_states.tap_and_hold
    if (did_tap_and_hold or was_tap_and_held) state = btn_states.tap_and_hold

    -- a "double tap" is two taps in rapid succession
    if (dbl_taps[sub(h, 0, 6)]) state = btn_states.dbl_tap

    -- a "double tap and hold" is a double tap followed almost immediately by a hold
    local did_dbl_tap_and_hold = dbl_tap_and_holds[sub(h, 0, 6)]
    local was_dbl_tap_and_held = btn(btn_id, player_id) and sub(h, 0, 1) == "" .. btn_states.dbl_tap_and_hold
    if (did_dbl_tap_and_hold or was_dbl_tap_and_held) state = btn_states.dbl_tap_and_hold

    push_state(btn_id, state)
  end
end

function build_strs()
  for i,btn_id in pairs(btn_ids) do
    local state = btns[btn_id].state
    local btn_label = btns[btn_id].label
    local state_label = state_labels[state]

    local color = state
    if (state == light_gray) color = state + 1

    local duration = 1
    if (state == btn_states.tap or state == btn_states.dbl_tap) duration = 12

    local str = {
      text = btn_label .. ": " .. state_label,
      x = 0,
      y = (i - 1) * 9,
      color = color,
      duration = duration,
      state = state
    }

    local has_cooled = strs[btn_id + 1].duration <= 0
    local is_override = state > strs[btn_id + 1].state
    if (has_cooled or is_override) strs[btn_id + 1] = str
  end
end

function draw_strs(x, y)
  for str in all(strs) do
    str.duration -= 1
    print(str.text, x + str.x, y + str.y, str.color)
  end
end

function _init()
  init_strs()
end

function _update()
  query_btns(0)
  build_strs()
end

function _draw()
  cls(light_gray)
  draw_strs(32, 36)
end

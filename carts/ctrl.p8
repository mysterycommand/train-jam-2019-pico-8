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

state_labels = {}
state_labels[btn_states.up] = "up"
state_labels[btn_states.down] = "down"
state_labels[btn_states.tap] = "tap"
state_labels[btn_states.hold] = "hold"
state_labels[btn_states.tap_and_hold] = "tap and hold"
state_labels[btn_states.dbl_tap] = "double tap"
state_labels[btn_states.dbl_tap_and_hold] = "double tap and hold"

btns = {}
btns[left]  = { label = "\x8b", state = btn_states.up, history = "" }
btns[right] = { label = "\x91", state = btn_states.up, history = "" }
btns[up]    = { label = "\x94", state = btn_states.up, history = "" }
btns[down]  = { label = "\x83", state = btn_states.up, history = "" }
btns[fire1] = { label = "\x8e", state = btn_states.up, history = "" }
btns[fire2] = { label = "\x97", state = btn_states.up, history = "" }

tap = {}
tap["01"] = true

hold = {}
hold["111111"] = true

tap_and_holds = {}
tap_and_holds["111112"] = true
tap_and_holds["111102"] = true

dbl_taps = {}
dbl_taps["201201"] = true
dbl_taps["201120"] = true
dbl_taps["201102"] = true
dbl_taps["201112"] = true

dbl_tap_and_holds = {}
dbl_tap_and_holds["111115"] = true
dbl_tap_and_holds["111105"] = true

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

cooling = {}

function _init()
end

function _update()
  query_btns(0)
end

function _draw()
  cls(light_gray)
  -- print(time(), 1, 1, black)

  for i,btn_id in pairs(btn_ids) do
    local state = btns[btn_id].state
    local btn_label = btns[btn_id].label
    local state_label = state_labels[state]
    local color = state

    if (state == light_gray) color = state + 1
    print(btn_label .. ": " .. state_label, 1, i * 9, color)
  end

  for co in all(cooling) do
    if (not coresume(co)) del(cooling, co)
  end
end

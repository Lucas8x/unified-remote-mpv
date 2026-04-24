local kb = libs.keyboard;
local fs = libs.fs;
local timer = libs.timer;
local win = libs.win;
local utf8 = libs.utf8
local tid = -1;
local title = "";

events.detect = function()
  return
    fs.exists("/usr/bin/mpv") or
    fs.exists("/bin/mpv") or
    fs.exists("C:/ProgramData/chocolatey/lib/mpvio.install/tools/mpv") or
    fs.exists("%appdata%/mpv");
end

events.focus = function()
  title = "";
  tid = timer.interval(actions.update, 500);
end

events.blur = function()
  timer.cancel(tid);
end

actions.switch = function()
	if OS_WINDOWS then
		win.switchtowait("mpv.exe");
	end
end

--@update current media status
actions.update = function()
  local hwnd = win.window("mpv.exe");
  local temp = win.title(hwnd);

  if (temp == "") then
    temp = "[Not Playing]";
  else
    local pos = utf8.lastindexof(temp, " - ");
    temp = utf8.sub(temp, 0, pos);
  end

  if (temp ~= title) then
    title = temp;
    layout.info.text = title;
  end
end

--@help Lower volume
actions.volume_down = function()
  actions.switch();
  kb.stroke("9");
end

--@help Mute volume
actions.volume_mute = function()
  actions.switch();
  kb.stroke("m");
end

--@help Raise volume
actions.volume_up = function()
  actions.switch();
  kb.stroke("0");
end

--@help Previous track
actions.previous = function()
  actions.switch();
  kb.stroke("<");
end

--@help Next track
actions.next = function()
  actions.switch();
  kb.stroke(">");
end

--@help Skip forward
actions.forward = function()
  actions.switch();
  kb.stroke("right");
end

--@help Skip backward
actions.backward = function()
  actions.switch();
  kb.stroke("left");
end

--@help Toggle play/pause state
actions.play_pause = function()
  actions.switch();
  kb.stroke("p");
end

--@help Stop playback
actions.stop = function()
  actions.switch();
  kb.stroke("q");
end

--@help Cycle through subtitles
actions.switch_subs = function()
  actions.switch();
  kb.stroke("j");
end

--@help Toggle subtitle visibility
actions.switch();
actions.toggle_subs = function()
  kb.stroke("v");
end

--@help Toggle fullscreen
actions.fullscreen = function()
  actions.switch();
  kb.stroke("f");
end

actions.osd = function()
  actions.switch();
  kb.stroke("O");
end

--@help Increase subtitle delay
actions.subtitle_delay_down = function()
  actions.switch();
  kb.stroke("z");
end

--@help Decrease subtitle delay
actions.subtitle_delay_up = function()
  actions.switch();
  kb.stroke("x");
end

--@help Increase audio delay
actions.audio_delay_down = function()
  actions.switch();
  kb.stroke("ctrl", "minus");
end

--@help Decrease audio delay
actions.audio_delay_up = function()
  actions.switch();
  kb.stroke("ctrl", "plus");
end

--@help Decrease playback speed
actions.playback_speed_down = function()
  actions.switch();
  kb.text("[");
end

--@help Increase playback speed
actions.playback_speed_up = function()
  actions.switch();
  kb.text("]");
end

--@help Reset playback speed
actions.playback_speed_reset = function()
  actions.switch();
  kb.stroke("backspace");
end

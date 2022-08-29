local mp = require "mp"
local utils = require "mp.utils"
local msg = require "mp.msg"
local home = os.getenv("HOME")
local mpv_cache = home .. "/.cache/mpv"
local title = ""
local origin = ""
local thumbnail = home .. "/Downloads/images/icons/Guyman-Helmet-Music-icon.png"

local function notify(summary, body, options)
  local option_args = {}
  for key, value in pairs(options or {}) do
    table.insert(option_args, string.format("--%s=%s", key, value))
  end
  return mp.command_native({
    "run", "notify-send", unpack(option_args),
    summary, body,
  })
end

local function notify_media()
  return notify(title, origin, {
    -- For some inscrutable reason, GNOME 3.24.2
    -- nondeterministically fails to pick up the notification icon
    -- if either of these two parameters are present.
    --
    -- urgency = "low",
    -- ["app-name"] = "mpv",

    -- ...and this one makes notifications nondeterministically
    -- fail to appear altogether.
    --
    -- hint = "string:desktop-entry:mpv",

    icon = thumbnail,
    --["replaces-process"] = "mpv-notification",
    --["replace-file"] = mpv_cache .. "/mpv_notification",
  })
end

local function set_data(metadata)
  local function tag(name)
    return metadata[string.upper(name)] or metadata[name]
  end

  local function parse_data(data)
    -- Return early if data has no hyphen
    if (string.find(data, "-") == nil) then
      return {data, nil}
    end
    local t = {}
    -- TODO: Address multiple hyphen

    for s in string.gmatch(data, "[^-]+") do
      table.insert(t, s)
    end

    t[2] = t[2]:gsub("^%s+", "")
    return t
  end

  local function update_origin(meta)
    return string.format("%s \n%s", origin, meta)
  end

  local ice = tag("icy-title")

  if (ice) then
    local data = parse_data(ice)
    origin = data[1]
    title = data[2]
    local icy_name = tag("icy-name")
    origin = update_origin(icy_name)
  else
    title = tag("title") or title
    origin = tag("artist_credit") or tag("artist") or origin

    local album = tag("album")
    if album then
      origin = update_origin(album)
    end

    local year = tag("original_year") or tag("year")
    if year then
      origin = update_origin(year)
    else
      local date = tag("date")
      if (date) then
        origin = update_origin(date)
      end
    end
  end

  return title, origin
end

local function initialize_data_from_filename()
  local path = mp.get_property_native("path")
  local dir, file = utils.split_path(path)

  -- TODO: handle embedded covers and videos?
  -- potential options: mpv's take_screenshot, ffprobe/ffmpeg, ...
  -- hooking off existing desktop thumbnails would be good too
  -- local thumbnail = find_cover(dir)

  title = file
  origin = dir
end

local function dump_cover()
  if mp.get_property('track-list/1/albumart') == "yes" then
    msg.log("info", "Cover art found. Dumping cover art...")

    local path = mp.get_property_native("path")
    local cover = mpv_cache .. "/mpv.jpg"

    mp.command_native({
      "run", "ffmpeg", "-loglevel", "quiet", "-y", "-i", path, "-map", "0:v", "-map", "-0:V", "-c", "copy", cover
    })

  msg.log( "info", "Command finished. Cover art dumped to " .. cover)
  thumbnail = cover
  end
end

local function update_data()
  initialize_data_from_filename()
  dump_cover()
end

local function notify_metadata_updated(name, metadata)
  if metadata then
    -- for name,val in pairs(metadata) do
    --   msg.log("info", name, ": ", val)
    -- end
    title, origin = set_data(metadata)
  end

  if (title ~= "") then
    msg.log("info", "Sending notification...")
    return notify_media(title, origin, thumbnail)
  end
end

mp.add_hook("on_preloaded", 50, update_data)
mp.observe_property("metadata", "native", notify_metadata_updated)

function on_pause_change(name, value)
    if value == true then
        PAUSE_CMD = "echo -e 'markup = require(\"lain.util.markup\") beautiful = require(\"beautiful\") nowplaying:set_markup(markup.font(beautiful.font, \"à\"))' | awesome-client"
        os.execute(PAUSE_CMD)
    end
end
mp.observe_property("pause", "bool", on_pause_change)

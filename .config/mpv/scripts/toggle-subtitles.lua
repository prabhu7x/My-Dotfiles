local mp = require("mp")

function toggle_subtitles()
    local current_state = mp.get_property_native("sub-visibility")
    if current_state == "yes" then
        mp.set_property("sub-visibility", "no")
    else
        mp.set_property("sub-visibility", "yes")
    end
end

mp.add_key_binding(nil, "toggle-subtitles", toggle_subtitles)


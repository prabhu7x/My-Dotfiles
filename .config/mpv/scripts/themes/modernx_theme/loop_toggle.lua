local function toggle_loop()
    local loop_status = mp.get_property_native("loop-file")
    if loop_status == "no" then
        mp.set_property("loop-file", "inf")
    else
        mp.set_property("loop-file", "no")
    end
end

mp.add_key_binding("c", "toggle_loop", toggle_loop)

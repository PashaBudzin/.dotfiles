local function require_conf(conf_path)
    local handle = io.popen(("hyprlang2lua %q"):format(conf_path), "r")
    if not handle then
        error("failed to run hyprlang2lua")
    end

    local lua_code = handle:read("*a")
    handle:close()

    local chunk, err = load(lua_code, "@" .. conf_path)
    if not chunk then
        error("failed to load generated lua: " .. err)
    end

    return chunk()
end

return {
    require_conf = require_conf
}

local spy = {}

function spy.find(methods, name, type)
    if (type == "table") then
        for i,v in pairs(methods.gc(true)) do
            if (type(v) == "table" and methods.info(v).name == name) then
                return v
            else
                warn("table/fucntion not found")
            end
        end
    elseif (type == "function") then
        for i,v in pairs(methods.gc()) do
            if (type(v) == "function" and not methods.is_closure(v) and methods.info(v).name == name) then
                return v
            else
                warn("table/fucntion not found")
            end
        end
    end
end

return(function(name, type)
    local methods = {
        ["getGc"] = getgc or get_gc_objects
        ["getInfo"] = debug.getinfo or getinfo
        ["isXClosure"] = is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or iselectronfunction or checkclosure
    }

    assert(methods.getGc, "exploit not supported")
    assert(methods.getInfo, "exploit not supported")
    assert(methods.isXClosure, "exploit not supported")

    return spy.find(methods, name, type)
end)

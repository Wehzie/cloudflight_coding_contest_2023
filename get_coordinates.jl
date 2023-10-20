include("structs.jl")

function get_tiletype(level, coordinate)
    m = level.map
    return m[coordinate...]
end
struct Level
    name::String
    size_of_map::Int
    map::Matrix{String}
    n_coordinates::Int
    coordinates::Vector{Tuple{Int64, Int64}}
end
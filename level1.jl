include("structs.jl")
include("loader.jl")
include("get_coordinates.jl")

function stringToLevel(input::String)::Level
    """populates a level struct from a string"""
    lines = split(input, "\n")
    size_of_map = parse(Int, lines[1])
    println(size_of_map)
    map = [lines[i] for i in 2:size_of_map+1]
    println("map: $map")
    n_coordinates = parse(Int, lines[size_of_map+2])
    println("n_coordinates: $n_coordinates")
    # a coordinate is of the form: 9,25\r
    coordinates = []
    for i in size_of_map+3:size_of_map+2+n_coordinates
        line = lines[i]
        println("line: $line")
        coord1 = parse(Int, split(line, ',')[1])
        coord2 = parse(Int, split(line, ',')[2])
        coord = [coord1, coord2]
        println("coord: $coord")
        print("coord type: ")
        println(typeof(coord))
        push!(coordinates, coord)
    end
    println("coordinates: $coordinates")
    # convert coordinates to a list of tuples
    coord_tup = [tuple(coordinates[i][1], coordinates[i][2]) for i in 1:n_coordinates]
    level = Level(size_of_map, map, n_coordinates, coord_tup)
    return level
end

function write_output(levels::Array{Level, 1})
   # create folder level1_output if it doesn't exist
    mkpath("level1_output")
    # traverse levels
    for level in levels
        outname = split(level.name, ".in")[1] * ".out"
        filename = "level1_output/$outname"
        open(filename, "w") do f
            # traverse coordinates and write tiletype to file
            for i in 1:level.n_coordinates
                coord = level.coordinates[i]
                tiletype = get_tiletype(level, coord)
                write(f, "$tiletype\n")
            end
        end
    end
end

function solve_level_1()
    files = readdir("level1")
    files = filter(contains(".in"), files)
    file_paths = joinpath.("level1", files)

    levels = read_level_to_struct.(file_paths)
    write_output(levels)
end

solve_level_1()
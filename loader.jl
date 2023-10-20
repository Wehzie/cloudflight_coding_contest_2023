include("structs.jl")

#loads file
function read_level(level_file)
    name = split(level_file,"/")[end]
    ndims, m, n_coords, coord_list = nothing,nothing,nothing,nothing
    open(level_file) do f
        ndims = readline(f) |> x -> parse(Int, x)
        
        #read map
        first_map_line = readline(f)
        length_of_lines = length(first_map_line)
        m = Matrix{String}(undef, (ndims,length_of_lines))
        m[1,:] .= split(first_map_line,"")
        
        for nline in 2:ndims
            m[nline, :] .= split(readline(f),"")
        end

        #read list of coordinates
        n_coords = readline(f) |> x -> parse(Int, x)
        coord_list = Tuple{Int64, Int64}[]
        for i in 1:n_coords
            line = readline(f)
            coords = ((split(line, ',') .|> x-> parse(Int, x)) .|> x-> x+1)
            x,y = coords
            coords = tuple(y,x)
            
            push!(coord_list, coords)
        end
    end
    return name, ndims, m, n_coords, coord_list
end

#loads file into the struct LEVEl
function read_level_to_struct(level_file)
    Level(read_level(level_file)...)
end
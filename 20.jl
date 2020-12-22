using StatsBase
open("20.txt") do f
    tiles::Dict{Int,BitArray{2}} = Dict()
    while !eof(f)
        id = parse(Int, readline(f)[6:9])
        tile = BitArray(undef, (10,10))
        for i in 1:10
            tile[i,:] = [c == '#' for c ∈ readline(f)]
        end
        tiles[id] = tile
        readline(f)
    end

    alledges = []
    for (_,t) ∈ tiles
        edges = [t[1,1:10], t[10,1:10], t[1:10,1], t[1:10,10]]
        push!(alledges, [edges; reverse.(edges)]...)
    end
    # println(length(Set(alledges)))
    # -> The number of unique edges (624) is for 144 tiles consistent
    # with a 12x12 grid of unique outer edges and unique inner-edge-pairs.

    outeredges = Set([e for (e, n) ∈ countmap(alledges) if n == 1])

    corners = []
    for (id, t) ∈ tiles
        edges = [t[1,1:10], t[10,1:10], t[1:10,1], t[1:10,10]]
        if sum([e ∈ outeredges for e ∈ edges]) == 2
            push!(corners, id)
        end
    end
    println("Part 1: ", prod(corners))

    #cobble pieces together while rotating and flipping as needed
    perms(t) = [t, rotr90(t), rot180(t), rotl90(t),
                t',rotr90(t'), rot180(t'), rotl90(t')]
    idmap = Array(zeros(12,12))
    remainingtiles = Set(keys(tiles))
    # top left corner, just take one and rotate as needed
    t = tiles[corners[1]]
    while !(t[1:10,1] ∈ outeredges && t[1,1:10] ∈ outeredges)
        t = rotr90(t)
    end
    tiles[corners[1]] = t
    idmap[1,1] = corners[1]
    delete!(remainingtiles, corners[1])
    # rest of first row
    for i ∈ 2:12
        redge = tiles[idmap[1,i-1]][1:10,10]
        for id ∈ remainingtiles, tp ∈ perms(tiles[id])
            if tp[1:10,1] == redge
                tiles[id] = tp
                idmap[1,i] = id
                delete!(remainingtiles, idmap[1,i])
                break
            end
        end
    end
    #rest of map
    for i ∈ 2:12, j ∈ 1:12
        dedge = tiles[idmap[i-1,j]][10,1:10]
        for id ∈ remainingtiles, tp ∈ perms(tiles[id])
            if tp[1,1:10] == dedge
                tiles[id] = tp
                idmap[i,j] = id
                delete!(remainingtiles, idmap[i,j])
                break
            end
        end
    end
    # cut away the edges
    seawithmonsters = BitArray(undef,(96,96))
    for i ∈ 1:12, j ∈ 1:12
        xr, yr = i*8-7:i*8, j*8-7:j*8
        seawithmonsters[xr, yr] = tiles[idmap[i,j]][2:9,2:9]
    end
    monster = BitArray([0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;
                        1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 1 1 1;
                        0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 0])
    monsterbits = sum(monster)
    seawithoutmonsters = deepcopy(seawithmonsters)
    for m ∈ perms(monster)
        mr, mc = size(m)
        for i ∈ 1:97-mr, j ∈ 1:97-mc
            if sum(seawithmonsters[i:i+mr-1,j:j+mc-1] .& m) == monsterbits
                seawithoutmonsters[i:i+mr-1,j:j+mc-1] .&= .!m
            end
        end
    end
    println("Part 2: ", sum(seawithoutmonsters))
end

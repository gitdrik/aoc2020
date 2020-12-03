open("03.txt") do f
    map = [[c == '#' for c in l] for l in eachline(f)]
    slopes =[(1,1),(1,3),(1,5),(1,7),(2,1)]
    ns = []
    for s in slopes
        n = 0
        y, x = 1, 1
        while y <= length(map)
            n += map[y][x]
            y += s[1]
            x = (x+s[2]-1) % length(map[1]) + 1
        end
        push!(ns, n)
    end
    println("Part 1: ", ns[2])
    println("Part 2: ", prod(ns))
end

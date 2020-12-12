open("11.txt") do f
    cs = [[c for c in s] for s in eachline(f)]
    cs2 = deepcopy(cs)
    p1, p2, ocs = 0, 0, []
    while ocs != cs
        ocs = deepcopy(cs)
        for i in 1:length(ocs), (j, c) in enumerate(ocs[i])
            if c == '.'
                continue
            end
            seated = 0
            for k in i-1:i+1, l in j-1:j+1
                if k ∈ 1:length(ocs) && l ∈ 1:length(ocs[k]) && !(k == i && l == j)
                    seated += ocs[k][l] == '#'
                end
            end
            if c == 'L' && seated == 0
                cs[i][j] = '#'
            elseif c == '#' && seated >= 4
                cs[i][j] = 'L'
            end
        end
    end
    p1 = sum(c == '#' for c in vcat(cs...))
    println("Part 1: ", p1)

    function someonethere(dr, dc, row, col, map)
        row, col = row+dr, col+dc
        if row ∈ 1:length(map) && col ∈ 1:length(map[row])
            if map[row][col] == '#'
                return true
            elseif map[row][col] == 'L'
                return false
            elseif map[row][col] == '.'
                return someonethere(dr, dc, row, col, map)
            end
        end
        return false
    end

    cs = deepcopy(cs2)
    p1, p2, ocs = 0, 0, []
    while ocs != cs
        ocs = deepcopy(cs)
        for i in 1:length(ocs), (j, c) in enumerate(ocs[i])
            if c == '.'
                continue
            end
            seated = 0
            for dr in -1:1, dc in -1:1
                if !(dr==0 && dc==0)
                    seated += someonethere(dr, dc, i, j, ocs)
                end
            end
            if c == 'L' && seated == 0
                cs[i][j] = '#'
            elseif c == '#' && seated >= 5
                cs[i][j] = 'L'
            end
        end
    end
    p2 = sum(c == '#' for c in vcat(cs...))
    println("Part 2: ", p2)
end

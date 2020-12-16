open("12.txt") do f
    ls = readlines(f)
    pos = [0,0]
    dir = 90
    for l ∈ ls
        c, n = l[1], parse(Int,l[2:end])
        if c == 'N'
            pos[1] += n
        elseif c == 'S'
            pos[1] -= n
        elseif c == 'E'
            pos[2] += n
        elseif c == 'W'
            pos[2] -=n
        elseif c == 'L'
            dir = mod(dir-n,360)
        elseif c == 'R'
            dir = mod(dir+n,360)
        elseif c == 'F'
            if dir == 0
                pos[1] += n
            elseif dir == 90
                pos[2] += n
            elseif dir == 180
                pos[1] -= n
            elseif dir == 270
                pos[2] -= n
            end
        end
    end
    println("Part 1: ", sum(abs.(pos)))

    pos = [0,0]
    wp = [1,10]
    for l ∈ ls
        c, n = l[1], parse(Int,l[2:end])
        if c == 'N'
            wp[1] += n
        elseif c == 'S'
            wp[1] -= n
        elseif c == 'E'
            wp[2] += n
        elseif c == 'W'
            wp[2] -=n
        elseif c == 'R'
            if n == 90
                wp = [-wp[2],wp[1]]
            elseif n == 180
                wp = [-wp[1],-wp[2]]
            elseif n == 270
                wp = [wp[2],-wp[1]]
            end
        elseif c == 'L'
            if n == 270
                wp = [-wp[2],wp[1]]
            elseif n == 180
                wp = [-wp[1],-wp[2]]
            elseif n == 90
                wp = [wp[2],-wp[1]]
            end
        elseif c == 'F'
            pos .+= wp.*n
        end
    end
    println("Part 2: ", sum(abs.(pos)))
end

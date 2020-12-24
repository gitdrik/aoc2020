open("24.txt") do f
    floor = BitArray(zeros(120,140))
    x0, y0 = 60, 70
    for l ∈ eachline(f)
        x, y = x0, y0
        while length(l) > 0
            d, l = l[1], l[2:end]
            if d == 'w'
                x -= 1
            elseif d == 'e'
                x += 1
            else
                dsub, l = l[1], l[2:end]
                x += dsub == 'w' ? -iseven(y) : isodd(y)
                y += d == 's' ? 1 : -1
            end
        end
        floor[x,y] = !floor[x,y]
    end
    println("Part 1: ", sum(floor))

    for t ∈ 1:100
        updates = []
        for x ∈ 2:size(floor,1)-1, y ∈ 2:size(floor,2)-1
            blacks = floor[x-1,y] + floor[x+1,y] + floor[x,y-1] + floor[x,y+1] +
                     floor[x+isodd(y)-iseven(y),y-1] + floor[x+isodd(y)-iseven(y),y+1]
            if floor[x,y]
                if blacks == 0 || blacks > 2
                    push!(updates,(x,y,0))
                end
            else
                if blacks == 2
                    push!(updates, (x,y,1))
                end
            end
        end
        for (x,y,v) ∈ updates
            floor[x,y] = v
        end
    end
    println("Part 2: ", sum(floor))
end

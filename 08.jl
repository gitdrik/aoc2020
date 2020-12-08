open("08.txt") do f
    P = []
    for l ∈ eachline(f)
        ins, ns = split(l)
        n = parse(Int, ns)
        push!(P, [ins, n])
    end

    i, seen = 1, Set()
    acc = 0
    while !(i ∈ seen)
        push!(seen, i)
        inc = 1
        if P[i][1] == "acc"
            acc += P[i][2]
        elseif P[i][1] == "jmp"
            inc = P[i][2]
        end
        i += inc
    end
    println("Part 1: ", acc)

    for j ∈ 1:length(P)
        nP = deepcopy(P)
        if nP[j][1] == "nop"
            nP[j][1] = "jmp"
        elseif nP[j][1] == "jmp"
            nP[j][1] = "nop"
        else
            continue
        end

        i, seen = 1, Set()
        acc = 0
        while !(i ∈ seen) && i ∈ 1:length(nP)
            push!(seen, i)
            inc = 1
            if nP[i][1] == "acc"
                acc += nP[i][2]
            elseif nP[i][1] == "jmp"
                inc = nP[i][2]
            end
            i += inc
        end
        if i == length(nP)+1
            println("Part 2: ", acc)
            break
        end
    end
end

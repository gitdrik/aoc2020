open("08.txt") do f
    P = []
    for l ∈ eachline(f)
        ins, ns = split(l)
        push!(P, [ins, parse(Int, ns)])
    end

    seen = falses(length(P))
    i, acc = 1, 0
    while !seen[i]
        seen[i] = true
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
        org = P[j][1]
        if org == "nop"
            P[j][1] = "jmp"
        elseif org == "jmp"
            P[j][1] = "nop"
        else
            continue
        end

        seen = falses(length(P))
        i, acc = 1, 0
        while i ∈ 1:length(P) && !seen[i]
            seen[i] = true
            inc = 1
            if P[i][1] == "acc"
                acc += P[i][2]
            elseif P[i][1] == "jmp"
                inc = P[i][2]
            end
            i += inc
        end
        if i == length(P)+1
            println("Part 2: ", acc)
            break
        end
        P[j][1] == org
    end
end

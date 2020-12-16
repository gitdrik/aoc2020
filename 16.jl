open("16.txt") do f
    ls = readlines(f)
    fields = []
    for l ∈ ls[1:20]
        r1, r2 = split(l,": ")[2] |> s->split(s," or ") .|>
                 s->split(s, '-') |> ss->parse.(Int, ss) |> r->r[1]:r[2]
        push!(fields, [r1, r2])
    end
    myticket = parse.(Int, split(ls[23],','))
    nearbys = [parse.(Int, split(l,',')) for l in ls[26:end]]
    p1 = sum([n for n ∈ Iterators.flatten(nearbys) if !any(n .∈ Iterators.flatten(fields))])
    println("Part 1: ", p1)

    valids = [myticket]
    for t ∈ nearbys
        valid = true
        for n ∈ t
            if !any(n .∈ Iterators.flatten(fields))
                valid = false
                break
            end
        end
        if valid
            push!(valids, t)
        end
    end

    tnfs = falses(length(valids), length(myticket), length(fields))
    for (i, t) ∈ enumerate(valids), (j, n) ∈ enumerate(t), (k, f) ∈ enumerate(fields)
        tnfs[i,j,k] = any(n .∈ f)
    end

    searchorder = sortperm([sum([all(tnfs[:,n,i]) for n ∈ 1:20]) for i ∈ 1:20])
    foundpos = []
    p2 = 1
    for i ∈ searchorder
        for j ∈ setdiff(Set(1:20), Set(foundpos))
            if all(tnfs[:,j,i])
                push!(foundpos, j)
                if i ∈ 1:6
                    p2 *= myticket[j]
                end
                break
            end
        end
    end
    println("Part 2: ", p2)
end

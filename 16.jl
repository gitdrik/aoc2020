open("16.txt") do f
    ls = readlines(f)
    fields = []
    for l in ls[1:20]
        r1, r2 = split(l,": ")[2] |> s->split(s," or ") .|>
                 s->split(s, '-') |> ss->parse.(Int, ss) |> r->r[1]:r[2]
        push!(fields, [r1, r2])
    end
    myticket = parse.(Int, split(ls[23],','))
    nearbys = [parse.(Int, split(l,',')) for l in ls[26:end]]
    p1 = sum([n for n in Iterators.flatten(nearbys) if !any(n .∈ Iterators.flatten(fields))])
    println("Part 1: ", p1)

    valids = [myticket]
    for t in nearbys
        valid = true
        for n in t
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

    fm = [sum([all(tnfs[:,n,i]) for n in 1:20]) for i in 1:20]
    searchorder = sortperm(fm)
    fieldorder = []
    p2 = 1
    for i ∈ searchorder
        for j in setdiff(Set(1:20), Set(fieldorder))
            if all(tnfs[:,j,i])
                push!(fieldorder, j)
                if i ∈ 1:6
                    p2 *= myticket[j]
                end
                break
            end
        end
    end
    println("Part 2: ", p2)
end

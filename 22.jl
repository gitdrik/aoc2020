open("22.txt") do f
    ls = readlines(f)

    ns1, ns2 = parse.(Int, ls[2:26]), parse.(Int, ls[29:53])
    while length(ns1) > 0 && length(ns2) > 0
        ns1, ns2 = ns1[1] > ns2[1] ?
            ([ns1[2:end];[ns1[1],ns2[1]]], ns2[2:end]) :
            (ns1[2:end], [ns2[2:end];[ns2[1],ns1[1]]])
    end
    p1 = length(ns2) == 0 ?
        sum(ns1 .* collect(length(ns1):-1:1)) :
        sum(ns2 .* collect(length(ns2):-1:1))
    println("Part 1: ", p1)

    function rcombat(ns1, ns2)
        # score is also a workable hash function for the state
        score(ns) = sum(ns .* collect(length(ns):-1:1))
        hist = Set{Tuple{Int, Int}}()
        while length(ns1) > 0 && length(ns2) > 0
            if (score(ns1),score(ns2)) ∈ hist
                return 1, score(ns1)
            end
            push!(hist, (score(ns1),score(ns2)))
            n1, n2 = popfirst!(ns1), popfirst!(ns2)
            win = length(ns1) >= n1 && length(ns2) >= n2 ?
                rcombat(deepcopy(ns1[1:n1]), deepcopy(ns2[1:n2]))[1] :
                n1 > n2 ? 1 : 2
            ns1, ns2 = win == 1 ? ([ns1;[n1,n2]], ns2) : (ns1, [ns2;[n2,n1]])
        end
        return length(ns2) == 0 ? (1, score(ns1)) : (2, score(ns2))
    end
    ns1, ns2 = parse.(Int, ls[2:26]), parse.(Int, ls[29:53])
    println("Part 2: ", rcombat(ns1,ns2)[2])
end

open("10.txt") do f
    ns = [parse(Int, s) for s in eachline(f)]
    sort!(ns)
    ns = [0; ns; ns[end]+3]
    diffs = ns[2:end].-ns[1:end-1]
    p1 = length(diffs[diffs.==1]) * length(diffs[diffs.==3])
    println("Part 1: ", p1)

    function valids(ns)
        if length(ns) == 1
            return 1
        end
        vs = 0
        for (i,n) ∈ enumerate(ns[2:end])
            if n-ns[1] ∈ 1:3
                vs += valids(ns[i+1:end])
            else
                break
            end
        end
        return vs
    end

    nss, pd = [], 1
    for d ∈ findall(a->a==3, diffs)
        push!(nss, ns[pd:d])
        pd = d+1
    end
    println("Part 2: ", prod(valids.(nss)))
end

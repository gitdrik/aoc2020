open("13.txt") do f
    l = [l for l ∈ eachline(f)]
    t0 = parse(Int, l[1])
    ns = [parse(Int, n) for n ∈ split(l[2],',') if n != "x"]
    tnext, id = findmin(ns .- t0 .% ns)
    println("Part 1: ", tnext*ns[id])

    ns2 = [(parse(Int,id), t-1) for (t, id) ∈ enumerate(split(l[2],',')) if id != "x"]
    p2, inc = 0, 1
    for nextbus ∈ ns2
        while ((p2+nextbus[2]) % nextbus[1]) != 0
            p2 += inc
        end
        inc *= nextbus[1]
    end
    println("Part 2: ", p2)
end

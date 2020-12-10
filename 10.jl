open("10.txt") do f
    ns = [parse(Int, s) for s in eachline(f)]
    sort!(ns)
    diffs = ns[2:end].-ns[1:end-1]
    p1 = length(filter(a->a==1,ns)) * length(filter(a->a==3,ns))
    println("Part 1: ", p1)
end

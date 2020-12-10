open("10.txt") do f
    ns = [parse(Int, s) for s in eachline(f)]
    sort!(ns)
    diffs = ns[2:end].-ns[1:end-1]
    p1 = length(diffs[diffs.==1]) * length(diffs[diffs.==3])
    println("Part 1: ", p1)
end

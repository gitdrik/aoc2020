open("10.txt") do f
    ns = [parse(Int, s) for s in eachline(f)]
    #ns = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    sort!(ns)
    push!(ns,ns[end]+3)
    diffs = ns[2:end].-ns[1:end-1]
    p1 = length(diffs[diffs.==1]) * length(diffs[diffs.==3])
    println("Part 1: ", p1)
end

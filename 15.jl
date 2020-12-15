function run(n)
    start = [8,11,0,19,1,2]
    older = Dict([(n,i) for (i,n) in  enumerate(start[1:end-1])])
    old, say = start[end], 0
    for i ∈ length(start)+1:n
        say = old ∈ keys(older) ? i-1-older[old] : 0
        older[old] = i-1
        old = say
    end
    return say
end
println("Part 1: ",run(2020))
println("Part 1: ",run(30000000))

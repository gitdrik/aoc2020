ns = open("01.txt") do f
    return [parse(Int, l) for l in eachline(f)]
end

function p1(ns)
    for i in 1:length(ns), j in i:length(ns)
        if ns[i]+ns[j] == 2020
            return ns[i]*ns[j]
        end
    end
end

function p2(ns)
    for i in 1:length(ns), j in i:length(ns), k in j:length(ns)
        if ns[i]+ns[j]+ns[k] == 2020
            return ns[i]*ns[j]*ns[k]
        end
    end
end

println("Part 1: ", p1(ns))
println("Part 2: ", p2(ns))

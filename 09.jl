open("09.txt") do f
    ns = [parse(Int, s) for s in eachline(f)]
    p1, p2 = 0, 0
    for i in 26:length(ns)
        valid = false
        for j in (i-25):(i-1), k in j+1:(i-1)
            if ns[i] == ns[j]+ns[k]
                valid = true
                break
            end
        end
        if !valid
            p1 = ns[i]
            break
        end
    end
    for i in 1:length(ns)-1
        s = ns[i]
        for j in i+1:length(ns)
            s += ns[j]
            if s == p1
                p2 = minimum(ns[i:j]) + maximum(ns[i:j])
                break
            end
            if p2 != 0
                break
            end
        end
    end
    println("Part 1: ", p1)
    println("Part 1: ", p2)
end

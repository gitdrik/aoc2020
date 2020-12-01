open("01.txt") do f
    ns = [parse(Int, l) for l in eachline(f)]
    for i in 1:length(ns), j in i:length(ns)
        if ns[i]+ns[j] == 2020
            println("Part 1: ", ns[i]*ns[j])
            break
        end
    end
    for i in 1:length(ns), j in i:length(ns), k in j:length(ns)
        if ns[i]+ns[j]+ns[k] == 2020
            println("Part 2: ", ns[i]*ns[j]*ns[k])
            break
        end
    end
end

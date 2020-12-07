open("07.txt") do f
    T = Dict()
    for l ∈ eachline(f)
        outer, inners = split(l, " bags contain ")
        if inners == "no other bags."
            T[outer] = Dict()
        else
            inners = split(inners, ", ")
            idict = Dict()
            for i in inners
                ss = split(i, ' ')
                idict[string(ss[2],' ',ss[3])] = parse(Int,ss[1])
            end
            T[outer] = idict
        end
    end

    function containsShinyGold(T, bag)
        if "shiny gold" in keys(T[bag])
            return true
        else
            if keys(T[bag]) == Set()
                return false
            else
                return any([containsShinyGold(T,b) for b in keys(T[bag])])
            end
        end
    end
    println("Part 1: ", sum([containsShinyGold(T, bag) for bag in keys(T)]))

    function bags(T, bag)
        if keys(T[bag]) == Set()
            return 0
        else
            return sum([bags(T,b)*T[bag][b] for b in keys(T[bag])]) +
                   sum(values(T[bag]))
        end
    end
    println("Part 2: ", bags(T, "shiny gold")) #!244
end

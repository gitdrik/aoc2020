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

    function contains_shiny_gold(T, bag)
        if "shiny gold" in keys(T[bag])
            return true
        else
            if isempty(T[bag])
                return false
            else
                return any([contains_shiny_gold(T,b) for b in keys(T[bag])])
            end
        end
    end
    println("Part 1: ", sum([contains_shiny_gold(T, bag) for bag in keys(T)]))

    function bags_in(T, bag)
        if isempty(T[bag])
            return 0
        else
            return sum([bags_in(T,b)*T[bag][b] for b in keys(T[bag])]) +
                   sum(values(T[bag]))
        end
    end
    println("Part 2: ", bags_in(T, "shiny gold")) #!244
end

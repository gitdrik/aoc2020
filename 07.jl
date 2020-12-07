open("07.txt") do f
    T = Dict()
    for l ∈ eachline(f)
        out, inns = split(l, " bags contain ")
        T[out] = Dict()
        if inns != "no other bags."
            for i in split(inns, ", ")
                ss = split(i, ' ')
                T[out][string(ss[2],' ',ss[3])] = parse(Int,ss[1])
            end
        end
    end

    contains_shiny_gold(T, bag) =
        "shiny gold" in keys(T[bag]) ||
        any([contains_shiny_gold(T,b) for b in keys(T[bag])])

    bags_in(T, bag) =
        isempty(T[bag]) ? 0 :
        sum(values(T[bag])) + sum([bags_in(T,b)*T[bag][b] for b in keys(T[bag])])

    println("Part 1: ", sum([contains_shiny_gold(T, bag) for bag in keys(T)]))
    println("Part 2: ", bags_in(T, "shiny gold"))

end

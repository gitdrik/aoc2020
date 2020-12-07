open("07.txt") do f
    T = Dict()
    for l ∈ eachline(f)
        bag, inns = split(l, " bags contain ")
        T[bag] = Dict()
        if inns != "no other bags."
            for i ∈ split(inns, ", ")
                ss = split(i, ' ')
                T[bag][string(ss[2],' ',ss[3])] = parse(Int,ss[1])
            end
        end
    end

    contains_shiny_gold(T, bag) =
        "shiny gold" ∈ keys(T[bag]) ||
        any([contains_shiny_gold(T,b) for b ∈ keys(T[bag])])

    bags_in(T, bag) =
        isempty(T[bag]) ? 0 :
        sum(values(T[bag])) + sum([bags_in(T,b)*T[bag][b] for b ∈ keys(T[bag])])

    println("Part 1: ", sum([contains_shiny_gold(T, bag) for bag ∈ keys(T)]))
    println("Part 2: ", bags_in(T, "shiny gold"))
end
